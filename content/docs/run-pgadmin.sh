#!/bin/bash
set -xv

# See https://www.pgadmin.org/download/pgadmin-4-apt/

sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
#sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/snapshots/2022-05-17/apt/jammy pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

#
# Install pgAdmin
#

# Install for both desktop and web modes:
sudo apt install pgadmin4

# Install for desktop mode only:
sudo apt install pgadmin4-desktop

# Install for web mode only:
#sudo apt install pgadmin4-web

# Configure the webserver, if you installed pgadmin4-web:
sudo /usr/pgadmin4/bin/setup-web.sh

# See http://127.0.0.1/pgadmin4

# for pgadmin
sudo apt install --reinstall pgadmin4 pgadmin4-desktop pgadmin4-web

exit 0
