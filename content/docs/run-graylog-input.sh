#!/bin/bash
ll /etc/graylog/server
cd /etc/elasticsearch/
sudo geany /etc/elasticsearch/elasticsearch.yml
discovery.type: single-node
network.host: 0.0.0.0
discovery.seed_hosts: []
sudo service elasticsearch restart
exit 0
