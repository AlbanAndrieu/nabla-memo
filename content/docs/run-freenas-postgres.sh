#!/bin/bash
#set -xv

# inside clamav jail

#NOK pkg install databases/postgresql13-server databases/postgresql13-client
# databases/postgresql-pgaudit
# pkg install databases/postgresql16-server databases/postgresql16-contrib
# postgresql16-client-16.6 conflicts with postgresql13-client-13.18
pkg install postgresql16-client

pkg install databases/postgresql16-server

# See ~postgres/data/postgresql.conf for more info
cat ~postgres/data/postgresql.conf

sysrc postgresql_enable=yes
# To initialize the database
service postgresql initdb
/usr/local/etc/rc.d/postgresql initdb
service postgresql start

grep listen_addresses /var/db/postgres/data16/postgresql.conf
listen_addresses = 'localhost,172.17.0.55,172.17.0.55,172.17.0.2,172.17.0.96'

# change authentication methods because default setting is insecure
cp -p /var/db/postgres/data16/pg_hba.conf /var/db/postgres/data16/pg_hba.conf.org
cat >/var/db/postgres/data16/pg_hba.conf <<'EOF'
local   all             all                                     peer
host    all             all             127.0.0.1/32            ident
host    all             all             127.17.0.1/32           ident
host    all             all             ::1/128                 ident
local   replication     all                                     peer
host    replication     all             127.0.0.1/32            ident
host    replication     all             127.17.0.1/32           ident
host    replication     all             ::1/128                 ident
EOF

su postgres
# /usr/local/bin/pg_ctl -D /var/db/postgres/data16 -l logfile start
cd /var/db/postgres/data16

cat /usr/local/etc/rc.d/postgresql
# as root
service postgresql start

# add OS user
pw useradd nabla -m
passwd nabla

export POSTGRES_USER="avnadmin"           # user nabla on clamav jaim
export POSTGRES_PASSWORD="password-reXXX" #

su - postgres

# add PostgreSQL user that name is the same with OS user
createuser nabla
createdb testdb -O nabla

# show users and databases
psql -c "select usename from pg_user;"

psql -l

# connect to testdb
psql testdb

# show user roles
\du

# show databases
\l

# show tables
\dt

exit 0
