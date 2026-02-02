#!/bin/bash
set -xv

# https://dev.to/zenika/how-to-deploy-a-secured-ovh-managed-kubernetes-cluster-using-terraform-in-2023-17o7

# sudo apt install postgresql-client-14
psql -h postgresql-a70ff71a-ob0ac5285.database.cloud.ovh.net -U avnadmin -p 20184 -d defaultdb

# ip route list

# ssh -i ~/.ssh/id_ed25519.pub ubuntu@postgresql-b99b1008-o412bbed9.database.cloud.ovh.net
# sudo apt-get install pgbouncer haproxy
# http://postgresql-b99b1008-o412bbed9.database.cloud.ovh.net:9001/

pg_dumpall --roles-only -f "/home/albandrieu/Downloads/roles.sql" --host "gradbintegr01.int.jusmundi.com" --port "5432" --username "postgres" --verbose
pg_dump --schema-only --no-publications -f "/home/albandrieu/Downloads/schema.sql" -d backdev  --host "gradbintegr01.int.jusmundi.com" --port "5432" --username "postgres" --verbose

psql -h gradbintegr01.int.jusmundi.com -U postgres
--DROP DATABASE  backdev;

# https://help.ovhcloud.com/csm/en-public-cloud-databases-postgresql-configure-instance?id=kb_article_view&sysparm_article=KB0049392
# https://medium.com/trendyol-tech/how-we-upgraded-postgresql-database-version-with-near-zero-downtime-12b1146c18e
psql -U avnadmin -d defaultdb  -h postgresql-b99b1008-o412bbed9.database.cloud.ovh.net -p 20184
select * from pg_user;
\l+
 \password postgres

# Create replication subscription
# https://aiven.io/docs/products/postgresql/howto/setup-logical-replication

psql -h gradbintegr01.int.jusmundi.com -U postgres
--show wal_level;

--ALTER SYSTEM SET wal_level = logical;
--SELECT pg_reload_conf();

sudo nano /etc/postgresql/10/main/postgresql.conf

sudo service postgresql status

show wal_level;
show max_replication_slots ;

# select * from pg_available_extensions
# CREATE EXTENSION aiven_extras CASCADE;
# CREATE DATABASE back

psql -U avnadmin -d back -h postgresql-b99b1008-o412bbed9.database.cloud.ovh.net -p 20184 -f "/home/albandrieu/Downloads/roles.sql"
psql -U back -d back -h postgresql-b99b1008-o412bbed9.database.cloud.ovh.net -p 20184 -f "/home/albandrieu/Downloads/schema.sql"

# FOR DEV and UAT restore
psql -U bofo -d back -h pg-core.service.gra.dev.consul -p 5432 -f "/home/albandrieu/Downloads/roles.sql"
psql -U bofo -d back -h pg-core.service.gra.dev.consul -p 5432 -f "/home/albandrieu/Downloads/schema.sql"

psql -U bofo -d back -h pg-core.service.gra.dev.consul -p 5432 -f ~/Downloads/jm-20240225.sql

# pg_create_subscription

psql -U avnadmin -d backdev -h postgresql-b99b1008-o412bbed9.database.cloud.ovh.net -p 20184
-- SELECT pg_terminate_backend(pid);

-- Run on source system
CREATE PUBLICATION publication_testalban_created_on_source FOR ALL TABLES;
-- CREATE PUBLICATION publication_testalban_created_on_source
-- FOR TABLE test_table,test_table_2,test_table_3
-- WITH (publish='insert,update,delete');

-- Run on destination system
--CREATE SUBSCRIPTION gib_new_pgs
--CONNECTION 'host=10.30.10.70 port=5432 user=postgres dbname=backdev'
--PUBLICATION publication_testalban_created_on_source;

# gradbintegr01.int.jusmundi.com
SELECT * FROM
aiven_extras.pg_create_subscription(
  'dest_subscription',
  'host=10.30.10.70 password=XXX port=5432 dbname=backdev user=postgres',
  'publication_testalban_created_on_source',
  'dest_slot',
  TRUE,
  TRUE);

SELECT * FROM pg_catalog.pg_stat_replication;

SELECT * FROM pg_extension;

CREATE EXTENSION IF NOT EXISTS plpgsql;
CREATE EXTENSION IF NOT EXISTS citext;
CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
CREATE EXTENSION IF NOT EXISTS unaccent;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
--CREATE EXTENSION IF NOT EXISTS plpython3u;

# https://postgresql-anonymizer.readthedocs.io/en/stable/#:~:text=postgresql_anonymizer%20is%20an%20extension%20to,a%20declarative%20approach%20of%20anonymization
CREATE EXTENSION IF NOT EXISTS anon CASCADE;
--SELECT anon.start_dynamic_masking();

--SELECT pg_catalog.setval(pg_get_serial_sequence('back_action_log', 'id'), (SELECT MAX(id) FROM back_action_log)+1);

SELECT query, total_time, calls, rows
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;

SELECT pg_stat_statements_reset();

SELECT MAX(id) FROM public.back_action_log;
--10397641

SELECT nextval('public."back_action_log_id_seq"');

SELECT setval('public."back_action_log_id_seq"',
  (SELECT MAX(id) FROM public.back_action_log)
);

SELECT pg_size_pretty( pg_database_size('backpreprod') );

SELECT oid::regclass::text  AS objectname
     , relkind   AS objecttype
     , reltuples AS entries
     , pg_size_pretty(pg_table_size(oid)) AS size  -- depending - see below
FROM   pg_class
WHERE  relkind IN ('r', 'i', 'm')
ORDER  BY pg_table_size(oid) DESC;

REFRESH MATERIALIZED VIEW public.v_arbitrator;
REFRESH MATERIALIZED VIEW public.v_lawyer;
REFRESH MATERIALIZED VIEW public.v_expert;
REFRESH MATERIALIZED VIEW public.v_tribunal;
REFRESH MATERIALIZED VIEW public.v_experience;

GRANT ALL ON SCHEMA public TO back;

select count(*) from security.access_log;

ANALYZE VERBOSE security.access_log ;

SELECT * FROM pg_stats WHERE tablename ='access_log';

# Perform a vacuum to rid the table of any dead rows and update the PostgreSQL planner with accurate, up-to-date statistics.
VACUUM ANALYZE;
# Query returned successfully in 5 min 47 secs.

SELECT pg_drop_replication_slot('dest_slot');

# check size of document table
assistant=> SELECT pg_size_pretty( pg_total_relation_size('document') );
 pg_size_pretty
----------------
 283 MB
(1 row)

exit 0
