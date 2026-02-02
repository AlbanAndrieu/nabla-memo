#!/bin/bash
set -xv

# See https://techviewleo.com/how-to-install-postgresql-database-on-ubuntu/

sudo apt -y install gnupg2 wget # vim

sudo apt --purge remove postgresql-*
sudo apt install -y postgresql-common -y

sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh

# sudo apt-cache search postgresql | grep postgresql
# sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
# wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt -y update

sudo apt -y install postgresql-client-16 # postgresql-client-14
# postgresql-16 : Depends: libllvm19 but it is not installable
sudo apt list | grep libllvm

sudo apt install postgresql-18

# https://github.com/llvm/llvm-project/issues/108995
# as root
curl -sL https://apt.llvm.org/llvm.sh | bash -s -- 19 all

sudo apt install llvm-19-dev

# sudo apt install postgresql postgresql-contrib
# NOK sudo apt install postgresql-16-pg-gvm

# Error: move_conffile: required configuration file /var/lib/postgresql/16/main/postgresql.conf does not exist
# Error: could not create default cluster. Please create it manually with
# pg_createcluster 16 main --start

# cat /var/lib/postgresql/18/main/postgresql.conf
sudo nano /etc/postgresql/18/main/postgresql.conf
listen_addresses = '*'

; Log successful and unsuccessful connection attempts.
log_connections = on

; Log terminated sessions.
log_disconnections = on

; Log all executed SQL statements.
log_statement = all

log_duration = on

sudo sed -i '/^host/s/ident/md5/' /etc/postgresql/18/main/pg_hba.conf
sudo sed -i '/^local/s/peer/trust/' /etc/postgresql/18/main/pg_hba.conf
echo "host all all 0.0.0.0/0 md5" | sudo tee -a /etc/postgresql/18/main/pg_hba.conf
sudo systemctl enable postgresql

systemctl status postgresql
service postgresql status

exit 0
