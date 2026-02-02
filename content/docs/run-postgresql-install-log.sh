#  https://medium.com/@josef.machytka/postgresql-recipes-logging-of-statements-6cc540da80bd

SHOW log_destination;
SHOW logging_collector;
SHOW log_directory;
SHOW log_min_messages;
SHOW log_line_prefix;

ALTER SYSTEM SET log_directory = 'logs';
ALTER SYSTEM SET log_filename = 'postgresql.log';

ALTER SYSTEM SET log_destination = 'stderr';
ALTER SYSTEM SET logging_collector = 'on';
ALTER SYSTEM SET log_min_duration_statement = 0;
# ALTER SYSTEM SET log_line_prefix = '%t [%p]: [%l-1] user=%u,db=%d,app=%a,client=%h ';
ALTER SYSTEM SET log_line_prefix = '%t [%p]: [%l] user=%u,db=%d,app=%a,client=%h,xid=%x %v ';
ALTER SYSTEM SET log_checkpoints = 'on';
ALTER SYSTEM SET log_connections = 'on';
ALTER SYSTEM SET log_disconnections = 'on';
ALTER SYSTEM SET log_lock_waits = 'on';
ALTER SYSTEM SET log_temp_files = 0;
ALTER SYSTEM SET log_autovacuum_min_duration = 0;
ALTER SYSTEM SET log_error_verbosity = 'verbose';
ALTER SYSTEM set log_statement = "all"

SELECT pg_reload_conf();
