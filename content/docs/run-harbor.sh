#!/bin/bash
set -xv
curl -LO https://raw.githubusercontent.com/bitnami/bitnami-docker-harbor-portal/master/docker-compose.yml > docker-compose.harbor.yml
docker-compose -f ./docker-compose.harbor.yml up
curl -sSL https://raw.githubusercontent.com/bitnami/bitnami-docker-nginx/master/docker-compose.yml > docker-compose.nginx.yml
gpg --keyserver hkps://keyserver.ubuntu.com --receive-keys 644FF454C0B4115C
gpg -v --keyserver hkps://keyserver.ubuntu.com --verify harbor-offline-installer-v2.0.0-rc1.tgz.asc
tar xvf harbor-offline-installer-v2.0.0-rc1.tgz
sudo mv harbor /opt/
pip3 install docker-compose
cd /opt/harbor
./install.sh --with-clair --with-chartmuseum
docker-compose down -v
nano harbor.yml
./prepare --with-clair --with-chartmuseum
sudo geany /lib/systemd/system/docker.service
sudo systemctl daemon-reload
docker-compose up -d
tail -f /var/log/harbor/registry.log
docker login http://albandrieu:6532
exit 0
