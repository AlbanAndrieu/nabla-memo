#!/bin/bash
pkg install postgresql16-client
pkg install databases/postgresql16-server
cat ~postgres/data/postgresql.conf
sysrc postgresql_enable=yes
service postgresql initdb
/usr/local/etc/rc.d/postgresql initdb
service postgresql start
grep listen_addresses /var/db/postgres/data16/postgresql.conf
listen_addresses = 'localhost,172.17.0.55,172.17.0.55,172.17.0.2,172.17.0.96'
cp -p /var/db/postgres/data16/pg_hba.conf /var/db/postgres/data16/pg_hba.conf.org
cat > /var/db/postgres/data16/pg_hba.conf << 'EOF'
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
cd /var/db/postgres/data16
cat /usr/local/etc/rc.d/postgresql
service postgresql start
pw useradd nabla -m
passwd nabla
export POSTGRES_USER="avnadmin"
export POSTGRES_PASSWORD="password-reXXX"
su - postgres
createuser nabla
createdb testdb -O nabla
psql -c "select usename from pg_user;"
psql -l
psql testdb
\du
\l
\dt
exit 0
