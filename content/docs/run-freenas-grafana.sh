#!/bin/bash
set -xv

# See https://www.truenas.com/community/threads/guide-to-setting-up-grafana-influxdb-metrics.88943/

# See http://172.17.0.24:3000/login

# http://172.17.0.24:3000/datasources

# http://172.17.0.24:30115/

pkg install grafana9
service grafana restart

pkg install influxdb
service influxd restart

#influx
influx -host 172.17.0.24 -port 30115 -username ${INFLUXDB_USER} -password ${INFLUXDB_PASSWORD}

SHOW USERS
SHOW DATABASES

create database graphite

use graphite
show series
show measurements

use telegraf
show measurements

SELECT last("value") FROM "uptime"

# https://blog.andreev.it/2019/04/freebsd-install-prometheus-node-exporter-and-grafana/

pkg install node_exporter

datasource : redis://172.17.0.55:6379

exit 0
