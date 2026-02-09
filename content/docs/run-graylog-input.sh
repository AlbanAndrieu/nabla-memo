#!/bin/bash
#set -xv
#set -eo pipefail

# Configure 2 Inputs :

# Syslog-UDP PfSense 1514
# Symfony GELF UDP 12203
# Syslog Remote 5140

# Install content-pack
# https://github.com/lmakonem/pfsense-graylog?tab=readme-ov-file#content-pack
# get https://github.com/lmakonem/pfsense-graylog/tree/master/pfsense_content_pack/graylog3/3-pfsense-analysis.json

# https://github.com/jbsky/graylog

# get https://raw.githubusercontent.com/lmakonem/pfsense-graylog/refs/heads/master/service-names-port-numbers/service-names-port-numbers.csv

ll /etc/graylog/server

cd /etc/elasticsearch/
sudo geany /etc/elasticsearch/elasticsearch.yml
discovery.type: single-node
network.host: 0.0.0.0
discovery.seed_hosts: []

sudo service elasticsearch restart

# Stream
# Rules contains filterlog

# Set store_full_message: false

exit 0
