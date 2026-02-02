#!/bin/bash
set -xv
sudo apt-get install curl
curl -s https://install.speedtest.net/app/cli/install.deb.sh|  sudo bash
sudo apt-get install speedtest
/usr/bin/speedtest --accept-license --accept-gdpr -f json-pretty
sudo geany /etc/telegraf/telegraf.d/speedtest.conf
select * from speedtest
exit 0
