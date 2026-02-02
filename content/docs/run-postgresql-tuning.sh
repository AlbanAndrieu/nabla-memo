#!/bin/bash
set -xv

./run-postgresql-install-log.sh

# https://www.datadoghq.com/blog/postgresql-monitoring-tools/

SELECT * FROM pg_stat_database;

SELECT * FROM pg_stat_database WHERE datname = 'employees';

SELECT * FROM pg_stat_user_tables;

SELECT * FROM pg_stat_user_indexes;

SELECT setting::float FROM pg_settings WHERE name = 'max_connections';
SELECT locktype, database, relation::regclass, mode, pid FROM pg_locks;

# See https://rizqimulki.com/postgres-performance-tuning-like-a-pro-2dd7f58d82d2
-- Essential baseline queries every pro runs first
SELECT name, setting, unit, context
FROM pg_settings
WHERE name IN (
    'shared_buffers', 'work_mem', 'maintenance_work_mem',
    'max_connections', 'effective_cache_size'
);

-- Current database activity
SELECT
    datname,
    numbackends,
    xact_commit,
    xact_rollback,
    blks_read,
    blks_hit,
    tup_returned,
    tup_fetched,
    tup_inserted,
    tup_updated,
    tup_deleted
FROM pg_stat_database;
-- Cache hit ratio (should be >99%)
SELECT
    round(100.0 * blks_hit / (blks_hit + blks_read), 2) as cache_hit_ratio
FROM pg_stat_database
WHERE datname = current_database();

-- Enable query statistics tracking
ALTER SYSTEM SET track_activity_query_size = 16384;
ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements,auto_explain,pg_qualstats';
-- Restart required
-- Find your worst queries
SELECT
    query,
    calls,
    total_time,
    mean_time,
    max_time,
    stddev_time,
    rows
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;

-- Find queries with high variance (inconsistent performance)
SELECT
    query,
    calls,
    mean_time,
    stddev_time,
    (stddev_time / mean_time) * 100 as variance_percentage
FROM pg_stat_statements
WHERE calls > 100
ORDER BY variance_percentage DESC
LIMIT 10;

-- Calculate your working set
SELECT
    datname,
    numbackends,
    xact_commit,
    xact_rollback,
    blks_read,
    blks_hit,
    tup_returned,
    tup_fetched,
    tup_inserted,
    tup_updated,
    tup_deleted
FROM pg_stat_database;
-- Cache hit ratio (should be >99%)
SELECT
    round(100.0 * blks_hit / (blks_hit + blks_read), 2) as cache_hit_ratio
FROM pg_stat_database
WHERE datname = current_database();


-- Calculate cache hit ratio
WITH table_stats AS (
    SELECT
        schemaname,
        relname ,
        n_tup_ins + n_tup_upd + n_tup_del as write_activity,
        seq_scan,
        seq_tup_read,
        idx_scan,
        idx_tup_fetch
    FROM pg_stat_user_tables
)
SELECT
    relname,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||relname)) as size,
    write_activity,
    seq_scan,
    CASE
        WHEN seq_scan > idx_scan THEN 'Sequential scan heavy'
        WHEN write_activity > 1000 THEN 'Write heavy'
        ELSE 'Normal'
    END as workload_type
FROM table_stats
ORDER BY pg_total_relation_size(schemaname||'.'||relname) DESC;

-- Find missing indexes (tables doing sequential scans)
SELECT
    schemaname,
    relname,
    seq_scan,
    seq_tup_read,
    seq_tup_read / seq_scan as avg_seq_tup_read
FROM pg_stat_user_tables
WHERE seq_scan > 0
ORDER BY seq_tup_read DESC;

-- Find unused indexes (wasting space and write performance)
SELECT
    schemaname,
    relname ,
    indexrelname ,
    pg_size_pretty(pg_relation_size(indexrelid)) as size,
    idx_scan,
    idx_tup_read,
    idx_tup_fetch
FROM pg_stat_user_indexes
WHERE idx_scan = 0
ORDER BY pg_relation_size(indexrelid) DESC;

-- Check index effectiveness
SELECT
    schemaname,
    tablename,
    indexname,
    idx_scan,
    idx_tup_read,
    idx_tup_fetch,
    idx_tup_read / NULLIF(idx_scan, 0) as avg_tuples_per_scan
FROM pg_stat_user_indexes
WHERE idx_scan > 0
ORDER BY idx_scan DESC;

-- Check vacuum performance
SELECT
    schemaname,
    relname,
    n_tup_ins,
    n_tup_upd,
    n_tup_del,
    n_dead_tup,
    last_vacuum,
    last_autovacuum,
    vacuum_count,
    autovacuum_count
FROM pg_stat_user_tables
WHERE n_dead_tup > 0
ORDER BY n_dead_tup DESC;

-- Check for bloat
SELECT
    schemaname,
    relname,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||relname)) as size,
    n_dead_tup,
    n_live_tup,
    round(100.0 * n_dead_tup / (n_live_tup + n_dead_tup), 2) as dead_tuple_percent
FROM pg_stat_user_tables
WHERE n_live_tup > 0
ORDER BY dead_tuple_percent DESC;

# https://medium.com/@jramcloud1/08-postgresql-17-complete-tuning-guide-for-vacuum-autovacuum-aa36b945a7cf
# See https://medium.com/@jramcloud1/08-postgresql-17-complete-tuning-guide-for-vacuum-autovacuum-aa36b945a7cf

-- Aggressive autovacuum for write-heavy tables
ALTER SYSTEM SET autovacuum_max_workers = 6;
ALTER SYSTEM SET autovacuum_naptime = '30s';
ALTER SYSTEM SET autovacuum_vacuum_threshold = 1000;
ALTER SYSTEM SET autovacuum_vacuum_scale_factor = 0.1;
ALTER SYSTEM SET autovacuum_analyze_threshold = 500;
ALTER SYSTEM SET autovacuum_analyze_scale_factor = 0.05;

-- For specific high-churn tables
ALTER TABLE high_activity_table SET (
    autovacuum_vacuum_threshold = 100,
    autovacuum_vacuum_scale_factor = 0.01,
    autovacuum_analyze_threshold = 50,
    autovacuum_analyze_scale_factor = 0.005
);

-- For specific high-write tables
ALTER TABLE high_activity_table SET (
    autovacuum_vacuum_threshold = 1000,
    autovacuum_vacuum_scale_factor = 0.05,
    autovacuum_analyze_threshold = 1000,
    autovacuum_analyze_scale_factor = 0.02
);

# Avoid VACUUM (FULL, VERBOSE, ANALYZE) high_activity_table;
# For PostgresqlTableNotAutoAnalyzed Run VACUUM ANALYZE high_activity_table;
# For PostgresqlTableNotAutoVacuumed Run VACUUM high_activity_table;

CREATE OR REPLACE VIEW performance_dashboard AS
SELECT
    'Cache Hit Ratio' as metric,
    round(100.0 * sum(blks_hit) / sum(blks_hit + blks_read), 2) || '%' as value,
    CASE
        WHEN round(100.0 * sum(blks_hit) / sum(blks_hit + blks_read), 2) > 99 THEN 'Good'
        WHEN round(100.0 * sum(blks_hit) / sum(blks_hit + blks_read), 2) > 95 THEN 'Warning'
        ELSE 'Critical'
    END as status
FROM pg_stat_database
UNION ALL
SELECT
    'Active Connections' as metric,
    count(*)::text as value,
    CASE
        WHEN count(*) < 100 THEN 'Good'
        WHEN count(*) < 150 THEN 'Warning'
        ELSE 'Critical'
    END as status
FROM pg_stat_activity
WHERE state = 'active'
UNION ALL
SELECT
    'Deadlocks' as metric,
    sum(deadlocks)::text as value,
    CASE
        WHEN sum(deadlocks) = 0 THEN 'Good'
        WHEN sum(deadlocks) < 10 THEN 'Warning'
        ELSE 'Critical'
    END as status
FROM pg_stat_database;

-- Check it regularly
SELECT * FROM performance_dashboard;

-- Enable parallel queries
ALTER SYSTEM SET max_parallel_workers_per_gather = 4;
ALTER SYSTEM SET max_parallel_workers = 8;
ALTER SYSTEM SET parallel_tuple_cost = 0.1;
ALTER SYSTEM SET parallel_setup_cost = 1000;

-- Force parallel query for testing
SET force_parallel_mode = on;
SET max_parallel_workers_per_gather = 4;

-- Automatic partition management
CREATE OR REPLACE FUNCTION create_monthly_partitions(table_name text)
RETURNS void AS $$
DECLARE
    start_date date;
    end_date date;
    partition_name text;
BEGIN
    start_date := date_trunc('month', CURRENT_DATE);
    end_date := start_date + interval '1 month';
    partition_name := table_name || '_' || to_char(start_date, 'YYYY_MM');

    EXECUTE format('CREATE TABLE IF NOT EXISTS %I PARTITION OF %I
                    FOR VALUES FROM (%L) TO (%L)',
                   partition_name, table_name, start_date, end_date);
END;
$$ LANGUAGE plpgsql;

-- For connection pooling optimization
ALTER SYSTEM SET max_connections = 200;  -- Lower than you think
ALTER SYSTEM SET shared_buffers = '2GB';  -- Higher per connection
ALTER SYSTEM SET max_prepared_transactions = 100;  -- Enable prepared statements

# See https://rizqimulki.com/the-postgresql-config-tweaks-that-scaled-to-1m-users-6129d4813882

exit 0
