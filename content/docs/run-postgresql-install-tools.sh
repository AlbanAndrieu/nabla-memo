#!/bin/bash
set -xv
sudo apt install pgtop
sudo su postgres
pg_top
sudo apt install libpq-dev python3-dev
CREATE EXTENSION pgaudit
set pgaudit.log = 'write, ddl'
set pgaudit.log_relation = on
set pgaudit.log = 'all, -misc'
set pgaudit.log = 'read, ddl'
set pgaudit.role = 'auditor'
brew install pgbadger
sudo apt-get install libjson-xs-perl
./run-postgresql-install-log.sh
/home/albandrieu/.linuxbrew/bin/pgbadger -I -O /var/www/nabla/public/reports /var/log/postgresql/postgresql-17-main.log
30 23 * * 1 /home/albandrieu/.linuxbrew/bin/pgbadger -q -w /var/log/postgresql/postgresql-17-main.log -o /var/www/nabla/public/reports
\dx
CREATE EXTENSION system_stats
exit 0
