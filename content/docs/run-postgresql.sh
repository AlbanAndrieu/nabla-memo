#!/bin/bash
set -euo pipefail

# PostgreSQL Installation and Configuration Script
# See https://www.cherryservers.com/blog/how-to-install-and-setup-postgresql-server-on-ubuntu-20-04

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_HOME="${HOME:-/home/${USER}}"
# Note: POSTGRES_PASSWORD is for reference/documentation purposes
# For production use, consider secure password management (vault, encrypted file, etc.)
POSTGRES_PASSWORD="${POSTGRES_PASSWORD:-}"
DEBUG="${DEBUG:-0}"

# Enable debug mode if DEBUG is set
if [[ "${DEBUG}" == "1" ]]; then
    set -xv
fi

# Trap handler for errors
trap 'echo "❌ Error on line ${LINENO}" >&2' ERR

./run-postgresql-install.sh

sudo -u postgres psql -c "SELECT version();"

psql --version

# See https://www.cherryservers.com/blog/how-to-install-and-setup-postgresql-server-on-ubuntu-20-04
sudo -u postgres psql
\conninfo
\l
\du
\du+ avnadmin
\password postgres

echo ${POSTGRES_PASSWORD}

# Show schema
\dnS

# show extension
\dx

# switch db
\connect back

# https://stackoverflow.com/questions/15301826/psql-fatal-role-postgres-does-not-exist

# WARNING port is 5433

# See https://www.postgresql.org/docs/14/libpq-envars.html

sudo -u postgres psql
ALTER USER postgres PASSWORD 'myPassword';

sudo geany /etc/postgresql/17/main/postgresql.conf

# restore dump

psql template1 -c 'drop database nablaapi;'
#psql -h localhost -U "albandrieu" -c "CREATE DATABASE nablaapi;"
psql template1 -c 'create database nablaapi with owner nablaapi;'

cp ${USER_HOME}/Downloads/nablaapi-2022-06-16-1200.sql .
psql nablaapi <nablaapi-2022-06-16-1200.sql

psql -f ${USER_HOME}/Downloads/nablaapi-2022-06-16-1200.sql -h nabladbuat01 -U nablaapi -d nablaapi
#psql -h nabladbuat01 -U dev -d nablaapi -W

# https://www.postgresql.org/docs/current/libpq-pgpass.html

# Password are stored in ~/.pgpass
# Or PGPASSWORD

ll ~/.pgpass
chmod 0600 ~/.pgpass
ll /var/lib/postgresql/
sudo less /var/lib/postgresql/.psql_history

echo $POSTGRES_PASSWORD
psql "host=localhost port=5432 user=postgres dbname=postgres"

# See https://dbeaver.io/
# flatpak install flathub io.dbeaver.DBeaverCommunity

psql -h pg-kong.service.gra.dev.consul -U kong -W

# No pg_hba.conf entry for host
sudo nano /etc/postgresql/10/main/pg_hba.conf

sudo su postgres
psql back
SELECT pg_reload_conf();

# https://pgtune.leopard.in.ua/#/
ALTER SYSTEM SET max_connections = 70;

nano /etc/postgresql/10/main/postgresql.conf

SHOW max_connections;

# keycloak backup

/usr/bin/pg_dump --file "/home/albandrieu/Downloads/keycloakdev-31-05-2023" --host "gradbintegr01.int.jusmundi.com" --port "5432" --username "postgres" --no-password --verbose --role "keycloak" --format=c --blobs "keycloakdev"
psql -h gradbintegr01.int.jusmundi.com -U postgres
DROP DATABASE keycloakuat;
create database keycloakuat with owner keycloak encoding 'UTF8';
SELECT * FROM JGROUPSPING;

cd /var/lib/postgresql/10/main/base

# https://postgres.hashnode.dev/postgres-missing-statistics-a-quick-fix-for-a-big-problem
# PostgresqlTableNotAutoAnalyzed

ANALYZE event_entity

select *
from pg_settings
where name like '%vacuum%'
or name = 'track_counts'
order by 1

# https://powa.readthedocs.io/en/latest/quickstart.html#install-powa-web-anywhere

# https://powa.readthedocs.io/en/latest/components/powa-web/index.html#powa-web-manual-installation
sudo apt-get install python3-pip python3-dev
sudo apt-get install python3-psycopg2 python3-sqlalchemy python3-tornado

pip3 install argcomplete
pip3 install powa-web
# sudo pipx install powa-web
# pipx install psycopg2
geany ~/.powa-web.conf

powa-web

# recovery
sudo apt install less most
export PATH="/usr/lib/postgresql/16/bin/:$PATH"

psql postgres://avnadmin:XXX@replica-postgresql-c50874b6-o412bbed9.database.cloud.ovh.net:20184/defaultdb?sslmode=require
SELECT * FROM pg_is_in_recovery();

psql postgresql://back:XXX@pg-gra.service.gra.dev.consul:5432/backdev
# on docker
psql -U avnadmin -d postgres -h localhost

exit 0
