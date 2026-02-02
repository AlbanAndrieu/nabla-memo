#!/bin/bash
set -xv
sudo snap remove dbeaver-ce
sudo add-apt-repository ppa:serge-rider/dbeaver-ce
sudo apt update
sudo apt install dbeaver-ce
which psql
sudo ln -s /usr/bin/pg_dump ~/pg_dump
ll /home/albanandrieu/pg_dump
sudo chmod 0600 /home/albanandrieu/.pgpass
/home/linuxbrew/.linuxbrew/Cellar/libpq/16.2_1/bin/pg_dump
ll ~/General-20240426.dbp
exit 0
