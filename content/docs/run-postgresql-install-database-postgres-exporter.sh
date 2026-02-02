-- To use IF statements, hence to be able to check if the user exists before
-- attempting creation, we need to switch to procedural SQL (PL/pgSQL)
-- instead of standard SQL.
-- More: https://www.postgresql.org/docs/9.3/plpgsql-overview.html
-- To preserve compatibility with <9.0, DO blocks are not used; instead,
-- a function is created and dropped.
CREATE OR REPLACE FUNCTION __tmp_create_user() returns void as $$
BEGIN
  IF NOT EXISTS (
          SELECT                       -- SELECT list can stay empty for this
          FROM   pg_catalog.pg_user
          WHERE  usename = 'postgres_exporter') THEN
    CREATE USER postgres_exporter;
  END IF;
END;
$$ language plpgsql;

SELECT __tmp_create_user();
DROP FUNCTION __tmp_create_user();

ALTER USER postgres_exporter WITH PASSWORD 'password';
ALTER USER postgres_exporter SET SEARCH_PATH TO postgres_exporter,pg_catalog;

-- If deploying as non-superuser (for example in AWS RDS), uncomment the GRANT
-- line below and replace <MASTER_USER> with your root user.
-- GRANT postgres_exporter TO <MASTER_USER>;

GRANT CONNECT ON DATABASE postgres TO postgres_exporter;

CREATE USER postgres_exporter WITH PASSWORD 'XXX';
GRANT USAGE ON SCHEMA postgres_exporter TO postgres_exporter;
GRANT SELECT ON postgres_exporter.pg_stat_activity TO postgres_exporter;
GRANT SELECT ON postgres_exporter.pg_stat_statements TO postgres_exporter;
-- ALTER USER postgres_exporter WITH SUPERUSER;
SELECT * FROM pg_ls_waldir() ORDER BY 1 ;
GRANT ALL ON FUNCTION pg_catalog.pg_ls_waldir() TO postgres_exporter;

# ERROR:  permission denied to grant role "pg_monitor"
# DETAIL:  Only roles with the ADMIN option on role "pg_monitor" may grant this role.
-- GRANT pg_monitor to keycloak with ADMIN OPTION;

CREATE EXTENSION IF NOT EXISTS pg_stat_statements
GRANT pg_monitor TO postgres_exporter
GRANT pg_read_all_stats to postgres_exporter;
GRANT USAGE ON SCHEMA postgres_exporter TO pg_monitor;

SELECT pg_reload_conf();
