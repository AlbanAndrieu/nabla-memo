#!/bin/bash
set -xv
sudo apt install lsb-core
lsb_release -a
psql --version
dpkg --get-selections|  grep postgres
RUN install -d /usr/share/postgresql-common/pgdg&&curl -k -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc|gpg --dearmor -o /usr/share/postgresql-common/pgdg/pgdg.gpg&&echo "deb [signed-by=/usr/share/postgresql-common/pgdg/pgdg.gpg] \
       https://apt.postgresql.org/pub/repos/apt \
       $(lsb_release -cs)-pgdg main" > \
/etc/apt/sources.list.d/pgdg.list
/usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y $(lsb_release -cs)
sudo apt update
sudo apt install postgresql-client-16 postgresql-client-18 postgresql-client postgresql-client-common
sudo apt purge postgresql-15
sudo apt install postgresql-18
sudo update-alternatives --install /usr/bin/pg_dump pg_dump /usr/lib/postgresql/18/bin/pg_dump 250
sudo update-alternatives --install /usr/bin/pg_dump pg_dump /usr/lib/postgresql/17/bin/pg_dump 200
sudo update-alternatives --install /usr/bin/pg_dump pg_dump /usr/lib/postgresql/16/bin/pg_dump 150
sudo update-alternatives --install /usr/bin/pg_dump pg_dump /usr/lib/postgresql/15/bin/pg_dump 100
sudo update-alternatives --config pg_dump
pg_dump --version
exit 0
