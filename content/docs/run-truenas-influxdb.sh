#!/bin/bash
influx server-config
export INFLUXDB_BIND_ADDRESS=http://0.0.0.0:30115/
export INFLUXDB_HTTP_AUTH_ENABLED=true
echo "http://172.17.0.24:30115/api/v2/config"
exit 0
