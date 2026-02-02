#!/bin/bash
set -xv

# local

docker exec -i docker-database-1 psql --username back --password back back < /mnt/data/temp/jm-20240428.sql
/usr/lib/postgresql/16/bin/pg_restore --verbose --host=localhost --port=5432 -f /mnt/data/temp/jm-20240428.sql


docker exec -i docker-keycloak-db-1 psql --username keycloak --password keycloak postgres < /mnt/data/temp/dump-keycloaklocal-202404261844.sql
/usr/lib/postgresql/16/bin/pg_restore --verbose --host=172.20.0.199 --port=5432 ****** --dbname=postgres /mnt/data/temp/dump-keycloaklocal-202404261844.sql

----- RESTORE

SELECT
    pg_terminate_backend(pid)
FROM
    pg_stat_activity
WHERE
    -- don't kill my own connection!
    pid <> pg_backend_pid()
    -- don't kill the connections to other databases
    AND datname = 'keycloakuat'
    ;

ALTER DATABASE keycloakuat RENAME TO "keycloakuat-2025-02-11";

create database keycloakuat with owner keycloak encoding 'UTF8';

# pg-gra (UAT) - keycloak
psql --host=pg-gra.service.gra.uat.consul --port=5432 --dbname=keycloakuat --username keycloak --password XXXX < /mnt/data/temp/dump-keycloakuat-202409051012.sql

psql --host=pg-gra.service.gra.uat.consul --port=5432 --dbname=keycloakuat --username keycloak --password XXXX < /mnt/data/temp/dump-keycloakuat-202502111724.sql

cd /opt/keycloak/bin
./kcadm.sh config credentials --server http://localhost:8080 --realm master --user noreply@jusmundi.com

# create user
./kcadm.sh create users -s username=jmkeycloak -s email=dev@jusmundi.com -s enabled=true -s emailVerified=true --server http://localhost:8080 --realm master
# Created new user with id '633c946d-8093-425b-a5ec-2695f01a0231'

# set password
./kcadm.sh set-password --server http://localhost:8080 --realm master --username jmkeycloak --new-password XXX

SELECT
    pg_terminate_backend(pid)
FROM
    pg_stat_activity
WHERE
    -- don't kill my own connection!
    pid <> pg_backend_pid()
    -- don't kill the connections to other databases
    AND datname = 'keycloakuat-2025-02-11'
    ;

CREATE DATABASE keycloakuat WITH TEMPLATE "keycloakuat-2025-02-11" OWNER keycloak;

exit 0
