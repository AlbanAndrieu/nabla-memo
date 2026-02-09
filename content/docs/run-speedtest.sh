#!/bin/bash
set -xv

#See https://www.speedtest.net/fr

#Ping 2 ms --> Guillaume 3 ms
#93.45 --> Guillaume 391.34 Mbps
#92.88 --> Guillaume 119.59 Mbps

# See https://static.cinay.eu/2020/09/28/InfluxDB-Telegraf-Grafana.html and https://github.com/risb0r/telegraf-speedtest for dashboard

## If migrating from prior bintray install instructions please first...
# sudo rm /etc/apt/sources.list.d/speedtest.list
# sudo apt-get update
# sudo apt-get remove speedtest
## Other non-official binaries will conflict with Speedtest CLI
# Example how to remove using apt-get
# sudo apt-get remove speedtest-cli
sudo apt-get install curl
curl -s https://install.speedtest.net/app/cli/install.deb.sh | sudo bash
sudo apt-get install speedtest

# In crontab
# 0 1 * * * /usr/bin/speedtest --accept-license --accept-gdpr
/usr/bin/speedtest --accept-license --accept-gdpr -f json-pretty

sudo geany /etc/telegraf/telegraf.d/speedtest.conf

select * from speedtest

# https://raw.githubusercontent.com/risb0r/telegraf-speedtest/master/Speedtest.net-metrics.json

# IP of remote are 45.91.22.*
# Ookla application

# Other speed tests
# https://speed.cloudflare.com/

# Download 300 Mbps
# Upload   500 Mbps

# https://www.waveform.com/tools/bufferbloat
# BUFFERBLOAT GRADE B

# Download 444 Mbps
# Upload   384 Mbps

exit 0
