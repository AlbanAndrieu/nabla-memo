
# SQL PROD :
ssh nabladbprod01
# sudo su postgres
sudo su - postgres
psql template1

ALTER DATABASE template1 REFRESH COLLATION VERSION;

#psql -U $DB_USER -h localhost -c"$DB_RECREATE_SQL"
psql -h nabladbprod01 -d nablaapi -U nablaapi -W

psql nablaapi

CREATE DATABASE back;

./run-postgresql-install-database-dev.sh

#GRANT ROOT TO albandrieu;
ALTER ROLE albandrieu WITH LOGIN
ALTER ROLE dev WITH LOGIN
ALTER ROLE nablaapi WITH LOGIN

CREATE ROLE albandrieu superuser
CREATE USER dev
CREATE USER nablaapi

ALTER USER nablaapi PASSWORD 'XXX'

grant usage on schema link to dev
grant select on all tables in schema link to dev

SELECT m.rolname AS "Role name"
   , roleid::regrole AS "Member of"
   , pg_catalog.concat_ws(', ', CASE WHEN pam.admin_option THEN 'ADMIN'  END
                , CASE WHEN m.rolinherit   THEN 'INHERIT' END
                , 'SET'
              ) AS "Options"
   , grantor::regrole AS "Grantor"
FROM  pg_catalog.pg_auth_members pam
JOIN  pg_catalog.pg_roles m ON pam.member = m.oid
ORDER BY 1, 2, 4;
