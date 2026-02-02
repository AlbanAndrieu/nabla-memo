#!/bin/bash
set -xv
./run-influxdb.sh
sudo apt-get install telegraf
sudo geany /etc/telegraf/telegraf.conf
[[outputs.influxdb]]
urls = ["http://172.17.0.24:30115"]
sudo systemctl restart telegraf
sudo journalctl -f -u telegraf.service
http://172.17.0.24:30115
user: $INFLUXDB_PFSENSE_USER
pass: $INFLUXDB_PFSENSE_PASSWORD
http://172.17.0.57:9200
sudo service telegraf restart
exit 0
