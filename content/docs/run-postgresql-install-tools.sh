#!/bin/bash
set -xv

sudo apt install pgtop
sudo su postgres
pg_top

# psycopg2 install error
sudo apt install libpq-dev python3-dev

# https://goteleport.com/blog/securing-postgres-postgresql/

# https://github.com/pgaudit/pgaudit
CREATE EXTENSION pgaudit

set pgaudit.log = 'write, ddl'
set pgaudit.log_relation = on

set pgaudit.log = 'all, -misc'
#set pgaudit.log_level = notice;

set pgaudit.log = 'read, ddl'

set pgaudit.role = 'auditor'

# https://dev.to/full_stack_adi/pgbadger-postgresql-log-analysis-made-easy-54ki

brew install pgbadger

sudo apt-get install libjson-xs-perl

./run-postgresql-install-log.sh

/home/albandrieu/.linuxbrew/bin/pgbadger -I -O /var/www/nabla/public/reports /var/log/postgresql/postgresql-17-main.log

30 23 * * 1 /home/albandrieu/.linuxbrew/bin/pgbadger -q -w /var/log/postgresql/postgresql-17-main.log -o /var/www/nabla/public/reports

# See https://medium.com/@fengruohang/the-idea-way-to-deliver-postgresql-extensions-35646464bb71

# show extension
\dx
CREATE EXTENSION system_stats;

exit 0
