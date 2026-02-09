#!/bin/bash
set -xv

# https://hackertarget.com/nessus-ubuntu-install/

sudo apt-get remove nessus*

curl --request GET \
  --url 'https://www.tenable.com/downloads/api/v2/pages/nessus/files/Nessus-10.7.3-ubuntu1404_amd64.deb' \
  --output 'Nessus-10.7.3-ubuntu1404_amd64.deb'

sudo dpkg -i ~/Downloads/Nessus-10.7.3-ubuntu1404_amd64.deb

# https://hub.docker.com/r/tenable/nessus
docker pull tenable/nessus:latest-ubuntu

scp ~/Downloads/Nessus-10.7.3-ubuntu1404_amd64.deb ubuntu@gra1crowdsec1:~

/etc/systemd/system/nessusd.service

sudo service nessusd status
sudo systemctl status nessusd.service

# sudo /opt/nessus/sbin/nessuscli chpasswd admin

echo https://albandrieu:8834/
echo https://gra1crowdsec1:8834/

# nabla
172.18.0.1/16, 172.17.0.1/16, 192.168.39.1/16, 10.10.0.126/24, 10.0.3.1/24, 82.66.4.247

/opt/nessus/sbin/terrascan version
# version: v1.19.1

exit 0
