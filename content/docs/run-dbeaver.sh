#!/bin/bash
set -xv

sudo snap remove dbeaver-ce

sudo add-apt-repository ppa:serge-rider/dbeaver-ce
sudo apt update
sudo apt install dbeaver-ce

# wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
# OK dbeaver-ce_24.2.0_amd64.deb

# https://stackoverflow.com/questions/65040874/how-to-configurate-the-home-client-in-dbeaver-for-postgresql

which psql

sudo ln -s /usr/bin/pg_dump ~/pg_dump
ll /home/albanandrieu/pg_dump
sudo chmod 0600 /home/albanandrieu/.pgpass

# brew install libpq
/home/linuxbrew/.linuxbrew/Cellar/libpq/16.2_1/bin/pg_dump

# Export connection configuration
# https://stackoverflow.com/questions/56561439/how-can-i-export-dbeaver-connection-configurations
# File > Export, under "DBeaver", select "Project", click Next
ll ~/General-20240426.dbp

# Install mysql driver
# https://dev.mysql.com/downloads/connector/j/
# mysql-connector-j_9.3.0-1ubuntu24.04_all.deb

exit 0
