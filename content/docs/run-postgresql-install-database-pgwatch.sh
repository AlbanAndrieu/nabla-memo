
--CREATE ROLE pgwatch2 WITH LOGIN PASSWORD 'pgwatch2admin';

CREATE ROLE pgwatch WITH LOGIN PASSWORD 'pgwatchpass';
CREATE DATABASE pgwatch OWNER pgwatch;
-- For critical databases it might make sense to ensure that the user account
-- used for monitoring can only open a limited number of connections
-- (there are according checks in code, but multiple instances might be launched)
ALTER ROLE pgwatch CONNECTION LIMIT 5;
--GRANT pg_monitor TO pgwatch;
GRANT pg_monitor TO pgwatch GRANTED BY postgres;
GRANT CONNECT ON DATABASE back TO pgwatch;
GRANT EXECUTE ON FUNCTION pg_stat_file(text) to pgwatch; -- for wal_size metric
GRANT EXECUTE ON FUNCTION pg_stat_file(text, boolean) TO pgwatch;
