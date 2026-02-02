
-- Create a group role that doesn t have ability to login by itself and
-- grant it SELECT privileged on the server inventory table.
CREATE ROLE dev;
GRANT SELECT ON back TO dev;

-- Create two user accounts which will inherit "dev" permissions upon
-- logging into the database.
CREATE ROLE alice LOGIN INHERIT;
CREATE ROLE bob LOGIN INHERIT;

-- Assign both user account to the "dev" group role.
GRANT dev TO alice, bob;

CREATE ROLE intern;
GRANT SELECT(id, description) ON back TO intern;
CREATE ROLE charlie LOGIN INHERIT;
GRANT intern TO charlie;

SELECT
  mv1.matviewname AS "materialized view",
  mv2.matviewname AS "depends on materialized view"
FROM pg_matviews mv1
JOIN pg_matviews mv2
  ON position(mv2.matviewname in mv1.definition) > 0
WHERE mv1.matviewname <> mv2.matviewname
ORDER BY mv1.matviewname;

# on UAT

CREATE DATABASE back owner postgres;

CREATE ROLE back;
CREATE ROLE front;
CREATE ROLE avnadmin;

RESTORE_OPTS="--create --clean --no-owner --verbose"; # This forces PostgreSQL to recreate tables, indexes, foreign keys, and constraints.
export RESTORE_OPTS="--verbose";
export DUMP_PATH="/home/albanandrieu/Downloads/jm-20251104.dump";

psql -f /workspace/users/albandrieu30/jm/infra/infrastructure/scripts/99-others/sql-scripts/roles-services.sql -h "localhost" -p "5432" -U "postgres" -d "back"
psql -f /workspace/users/albandrieu30/jm/infra/infrastructure/scripts/99-others/sql-scripts/roles-users.sql -h "localhost" -p "5432" -U "postgres" -d "back"

pg_restore -h "localhost" -p "5432" -U "postgres" -d "back" ${RESTORE_OPTS} "${DUMP_PATH}"

grant usage on schema users to postgres;
grant usage on schema queue to postgres;
grant usage on schema elastic to postgres;
grant usage on schema public to postgres;
grant all privileges on all tables in schema users to postgres;
