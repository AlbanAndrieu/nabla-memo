#!/bin/bash
set -xv

./run-elasticsearch.sh

sudo apt remove opendistroforelasticsearch-kibana

sudo apt-get install kibana

sudo service kibana start
sudo systemctl restart kibana.service

cd /usr/share/elasticsearch/bin/
/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana

echo http://localhost:5601/

exit 0
