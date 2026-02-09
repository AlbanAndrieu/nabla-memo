#!/bin/bash
set -xv

# https://github.com/cucac/truenas-influxdb-grafana

#See https://rudimartinsen.com/2018/04/12/monitoring-freenas-with-influxdb-and-grafana/

#docker run --rm influxdb:1.8.0 influxd config > influxdb.conf

# influxdb 1.8.2

echo "deb https://repos.influxdata.com/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install influxdb influxdb-client

sudo systemctl enable --now influxdb

systemctl status influxdb

curl -XPOST "http://localhost:8086/query" \
  --data-urlencode "q=CREATE USER nabla WITH PASSWORD 'XXX' WITH ALL PRIVILEGES"  #nosec allow:gitleaks

USER="nabla:XXX"; #nosec allow:gitleaks

curl -G http://localhost:8086/query -u $USER --data-urlencode "q=SHOW DATABASES"

curl -XPOST "http://localhost:8086/query" -u $USER \
  --data-urlencode "q=CREATE USER telegraf WITH PASSWORD 'XXX' WITH ALL PRIVILEGES" #nosec allow:gitleaks

sudo nano /etc/influxdb/influxdb.conf

#influx -username 'nabla' -password 'XXX'
influx  -host 172.17.0.57 -port 8086 -username 'nabla' -password 'XXX'

#use graphite
#show series
#show measurements

# graphite 1.1.4
#sudo apt-get install graphite-web graphite-carbon
docker run -d \
--name graphite \
--restart=always \
-p 8083:80 \
-p 2003-2004:2003-2004 \
-p 2023-2024:2023-2024 \
-p 8125:8125/udp \
-p 8126:8126 \
graphiteapp/graphite-statsd

# See http://localhost:8083/

#cat /etc/carbon/carbon.conf | egrep -v '#' | sed '/^$/d'

echo "foo.bar 1 `date +%s`" | nc localhost 2003

sudo geany /etc/default/graphite-carbon
#Change to true, to enable carbon-cache on boot
#CARBON_CACHE_ENABLED=true
sudo systemctl start carbon-cache

/usr/lib/influxdb/scripts/influxd-systemd-start.sh

sudo lsof -i :8086
sudo lsof -i :30115
sudo lsof -i :2003
netstat -a | grep LIST | grep tcp
echo "local.random.diceroll 4 `date +%s`" | nc -v localhost 2003
sudo netstat -naptu | grep LISTEN | grep influxd

# See https://community.influxdata.com/t/influxdb-2-0-does-not-support-graphite-anymore/17289

./run-telegraf.sh

# influx  -host 172.17.0.57 -port 8086 -username 'telegraf' -password 'microsoft'

influx  -host 172.17.0.57 -port 8086 -username telegraf -password probing-XXX

influx  -host 172.17.0.24 -port 30115 -username nabla -password XX
influx  -host 172.17.0.24 -port 30115 -username 'nabla' -password 'XXX'
influx  -host 172.17.0.24 -port 30115 -username ${INFLUXDB_PFSENSE_USER} -password ${INFLUXDB_PFSENSE_PASSWORD}

#DROP DATABASE telegraf
create database telegraf

# See http://172.17.0.57:30115/
# See http://172.17.0.24:30115/
# See http://localhost:30115/

use telegraf
# clean everything
#DROP SERIES FROM /.*/
show series
show measurements

SELECT ("temperature") FROM "ada1" WHERE ("resource" = 'disktemp')

# /var/lib/influxdb
cd /var/lib/
ln -s /data/influxdb influxdb
# e2fsck -fy /dev/mapper/vgubuntu-root
e2fsck -fy /dev/mapper/vg--sata-data

# wget https://dl.influxdata.com/influxdb/releases/influxdb2-client-2.3.0-linux-amd64.tar.gz
brew install influxdb-cli

influx config create --config-name onboarding \
    --host-url "http://172.17.0.24:30115" \
    --org "a3eXX" \
    --token "X-X-X==" \
    --active

# influx bucket create --name sample-bucket -c onboarding
# influx write --bucket my-loki --file downloads/air-sensor-data-annotated.csv
influx write --bucket my-loki --url https://influx-testdata.s3.amazonaws.com/air-sensor-data-annotated.csv

influx -database 'metrics' -execute 'select * from cpu' -format 'json' -pretty

exit 0
