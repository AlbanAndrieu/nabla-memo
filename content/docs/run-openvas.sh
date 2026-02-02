#!/bin/bash
set -xv

# Open source Vulnerability Assessment Scanner
# https://github.com/greenbone/openvas-scanner

./run-openvas-ubuntu-install.sh

# sudo apt install postgresql

./run-postgresql.sh
sudo lsof -i :5432
sudo service postgresql start

docker ps | grep pg
docker exec -it edeca11abc07 bash
su - postgres
# https://tableplus.com/blog/2018/07/postgresql-how-to-create-new-user.html
CREATE USER openvas WITH PASSWORD '${POSTGRES_OPENVAS_PASSWORD}'
CREATE DATABASE gvmd WITH OWNER openvas ENCODING 'UTF8'
GRANT ALL PRIVILEGES ON DATABASE gvmd to openvas
GRANT ALL PRIVILEGES ON DATABASE gvmd to gvmd
ALTER ROLE openvas SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN REPLICATION NOBYPASSRLS

SELECT
    pg_terminate_backend(pid)
FROM
    pg_stat_activity
WHERE
    -- don't kill my own connection!
    pid <> pg_backend_pid()
    -- don't kill the connections to other databases
    AND datname = 'gvmd'
    ;

ALTER DATABASE gvmd RENAME TO "gvmd-2024-12-02";
create database gvmd with owner gvmd;
psql -f /mnt/data/temp/dump-gvmd-202411291738.sql -h gra1crowdsec1 -U postgres -d gvmd
echo ${POSTGRES_PASSWORD}

docker exec -it greenbone-community-edition-openvas-1 bash
cat /etc/openvas/openvas.conf
cat /etc/openvas/openvas_log.conf

# For k8s
# See https://github.com/greenbone/openvas-scanner/blob/main/charts/openvasd/templates/deployment.yaml

# /var/lib/postgresql/13/main/base/16385# du -sh * | grep M
sudo docker system df -v

docker volume inspect --format '{{ .Mountpoint }}' greenbone-community-edition_psql_data_vol
sudo du -sh $(docker volume inspect --format '{{ .Mountpoint }}' greenbone-community-edition_psql_data_vol)

echo "" > $(docker inspect --format='{{.LogPath}}' greenbone-community-edition-gvmd-1)

echo "http://127.0.0.1:9392/login"
 # Use "admin" as username and password

echo "http://127.0.0.1:3000/"

# docker run -d -p 443:443 -e OV_PASSWORD=securepassword41 --name openvas mikesplain/openvas

sudo su - postgres
psql gvmd
gvmd=# \dn

# change password

# Docker
docker pull greenbone/openvas-scanner:23.3

# https://greenbone.github.io/docs/latest/22.4/container/index.html
cd ~/greenbone-community-container

curl -f -O https://greenbone.github.io/docs/latest/_static/setup-and-start-greenbone-community-edition.sh && chmod u+x setup-and-start-greenbone-community-edition.sh
export DOWNLOAD_DIR=$HOME/greenbone-community-container && mkdir -p $DOWNLOAD_DIR
sudo ./setup-and-start-greenbone-community-edition.sh

ln -s $HOME/w/jm/infra/openvas $HOME/greenbone-community-container
# ln -s docker-compose-22.4.yml docker-compose.yml

# greenbone/gsa:stable

# start
# docker compose -f docker-compose.yml -p greenbone-community-edition up -d
sudo service postgresql stop
sudo service redis stop
docker compose -f docker-compose.yml -p greenbone-community-edition up -d
docker compose -f docker-compose.yml -p greenbone-community-edition logs -f
netstat -alnp | grep LISTEN

10.30.10.1/24, 10.10.10.1/24, 10.11.0.1/24, 10.20.10.1/24, 10.21.0.1/24

prod 10.20.10.1/24, 10.20.0.1/24, 10.21.0.1/24
build 10.30.10.1/24, 10.30.0.1/24, 10.31.0.1/24
mgt 10.10.10.1/24, 10.10.0.1/24, 10.11.0.1/24

# nabla
172.18.0.1/24, 172.17.0.1/24, 192.168.39.1/24, 10.10.0.126/24, 10.0.3.1/24, 82.66.4.247

docker compose -f docker-compose.yml -p greenbone-community-edition up vulnerability-tests
docker logs greenbone-community-edition-vulnerability-tests-1
docker logs greenbone-community-edition-scap-data-1

greenbone-community-edition_vt_data_vol
greenbone-community-edition_scap_data_vol
sudo docker volume rm greenbone-community-edition_scap_data_vol greenbone-community-edition_vt_data_vol

sudo docker compose -f docker-compose.yml -p greenbone-community-edition logs openvasd gvmd gsa -f

sudo docker compose -f docker-compose.yml -p greenbone-community-edition up pg-gvm
docker exec -it greenbone-community-edition-pg-gvm-1 bash

./run-gpg-decrypt.sh

# To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.

# https://securitytrails.com/blog/openvas-vulnerability-scanner#content-installing-on-ubuntu-2004
# SQL ports list
# T:1433,3306,3050,5432,3351

# https://www.hackingtutorials.org/scanning-tutorials/vulnerability-scanning-with-openvas-9-scanning-the-network/

# Issue scanner not working : set_socket: failed to open ICMPV4 socket: Operation not permitted
# https://forum.greenbone.net/t/set-socket-failed-to-open-icmpv4-socket-operation-not-permitted/13702/4
# openvas-1              | libgvm boreas:WARNING:2024-10-14 18h30.01 utc:86: set_socket: failed to open ICMPV4 socket: Operation not permitted
# ospd-openvas-1  OSPD[7] 2024-10-14 18:30:03,421: INFO: (ospd.ospd) e9f88010-50b4-4fe4-9182-897aa4037de2: Host scan finished.

exit 0
