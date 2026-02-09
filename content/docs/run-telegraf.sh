#!/bin/bash
set -xv

./run-influxdb.sh

# See https://github.com/influxdata/telegraf
sudo apt-get install telegraf
sudo geany /etc/telegraf/telegraf.conf

# Redirect to grafana influxdb

#[[outputs.influxdb]]
#  ## The full HTTP or UDP URL for your InfluxDB instance.
#  ##
#  ## Multiple URLs can be specified for a single cluster, only ONE of the
#  ## urls will be written to each interval.
#  # urls = ["unix:///var/run/influxdb.sock"]
#  # urls = ["udp://127.0.0.1:8089"]
#  # urls = ["http://127.0.0.1:30115"]
#  urls = ["http://10.20.0.96:30115"]

[[outputs.influxdb]]
# urls = ["http://172.17.0.24:30115"]
urls = ["http://172.17.0.24:30115"]

sudo systemctl restart telegraf
sudo journalctl -f -u telegraf.service
# docker pull telegraf

# in pfsense

# https://172.17.0.1:10443/pkg_edit.php?xml=telegraf.xml
http://172.17.0.24:30115
user: ${INFLUXDB_PFSENSE_USER} # telegraf
pass: ${INFLUXDB_PFSENSE_PASSWORD} # micros

http://172.17.0.57:9200

# See dashboard http://172.17.0.24:3000/d/GflT1CsMz/pfsense-system-dashboard?orgId=1&refresh=10s

sudo service telegraf restart

exit 0
