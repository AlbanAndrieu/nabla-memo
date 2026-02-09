#!/bin/bash
set -xv

# See https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html

#sudo apt-get install elasticsearch-oss
#sudo apt remove elasticsearch-oss
sudo apt remove elastic*

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
sudo apt-get install apt-transport-https
#nano  /etc/apt/sources.list.d/elastic-8.x.list
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/9.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-9.x.list
sudo apt-get update && sudo apt-get install elasticsearch elasticsearch-curator

sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic

sudo systemctl enable --now elasticsearch.service

sudo systemctl start elasticsearch.service
sudo systemctl stop elasticsearch.service

sudo usermod -a -G elasticsearch kibana
sudo systemctl restart kibana.service
sudo journalctl -u kibana

#test
curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic https://localhost:9200

curl -XGET 'localhost:9200/_cat/nodes?v&pretty'

#See http://172.21.0.4:9200/

http://localhost:9200/_plugin/gui/index.html

#http://localhost:5601/app/kibana#/management/elasticsearch/remote_clusters/list?_g=()
#0.0.0.0:9300

# See UI http://localhost:5001/#!/clusters/docker-cluster

#sudo nano /lib/systemd/system/elasticsearch.service

#install monitoring plugins
#http://www.elastichq.org/support_plugin.html
cd /usr/share/elasticsearch/bin
sudo ./plugin remove royrusso/elasticsearch-HQ
sudo ./plugin install royrusso/elasticsearch-HQ
echo http://localhost:9200/_plugin/HQ/

tail -f /var/log/elasticsearch/elasticsearch.log

#clean up elasticsearch
#install elasticsearch-curator
#sudo apt-get install python-pip
#sudo pip install elasticsearch-curator
#curator --help
#http://www.elastic.co/guide/en/elasticsearch/client/curator/current/examples.html
#curator --host 127.0.0.1 show indices --timestring '%Y.%m.%d'
#curator --host 127.0.0.1 delete indices --older-than 30 --time-unit days --timestring '%Y.%m.%d'
##curator --host 127.0.0.1 close indices --exclude do-not-touch --exclude logstash-2015
#curator --host 127.0.0.1 close indices --exclude do-not-touch --exclude kibana-int
#curator --host 127.0.0.1 delete indices --index logstash-2015.04.29
ll /var/lib/elasticsearch/elasticsearch/nodes/
ls /var/lib/elasticsearch/nodes

# Elasticsearch
#max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
#sysctl -w vm.max_map_count=262144
sudo nano /etc/sysctl.conf
#kernel.core_pattern=/home/jenkins/coredumps/core-%e-%p-%t
vm.max_map_count=262144

mkdir /data/elasticsearch/
cd /data/elasticsearch/
cd /usr/share/elasticsearch/
sudo ln -s /data/elasticsearch/data data

sudo nano /etc/elasticsearch/elasticsearch.yml
# network.host: 0.0.0.0

# red cluster
# need to change number of replica
# https://www.elastic.co/guide/en/elasticsearch/reference/8.6/red-yellow-cluster-status.html#:~:text=A%20red%20status%20means%20one%20or%20more%20primary%20shards%20are%20unassigned.&text=To%20view%20unassigned%20shards%2C%20use%20the%20cat%20shards%20API.&text=Unassigned%20shards%20have%20a%20state%20of%20UNASSIGNED%20

# curl -XGET 'http://jaeger-elasticsearch.service.gra.uat.consul/_cat/indices?s=index&v=true'

# curl -XGET 'http://jaeger-elasticsearch.service.gra.uat.consul/_cat/shards'

# curl -XDELETE 'http://jaeger-elasticsearch.service.gra.uat.consul/jaeger-service-*?pretty'
# curl -XDELETE 'http://jaeger-elasticsearch.service.gra.uat.consul/jaeger-span-*?pretty'
# http://jaeger-elasticsearch.service.gra.uat.consul/_cluster/health
# curl -XPOST 'http://jaeger-elasticsearch.service.gra.uat.consul/_reindex?wait_for_completion=false&pretty'

# curl -XGET 'http://jaeger-elasticsearch.service.gra.uat.consul/_cat/indices?s=index&v=true'
# curl -q -s "http://jaeger-elasticsearch.service.gra.uat.consul/jaeger-span-2023-02-23/_settings"
# curl -X PUT -H "Content-Type: application/json" "http://jaeger-elasticsearch.service.gra.uat.consul/jaeger-span-2023-02-23/_settings" -d '{ "number_of_replicas": 0 }'
# curl -X PUT -H "Content-Type: application/json" "http://jaeger-elasticsearch.service.gra.uat.consul/jaeger-service-2023-02-23/_settings" -d '{ "number_of_replicas": 0 }'

curl -X POST -u elastic:xxxxxxx "http://localhost:9200/_cluster/reroute?retry_failed=true"

curl -X POST "http://jaeger-elasticsearch.service.gra.uat.consul/_cluster/reroute?retry_failed=true"

#curl -XGET http://jaeger-elasticsearch.service.gra.uat.consul/_cluster/allocation/explain\?pretty\=true | jq
curl -X GET "http://gradbsev2integr01.int.nabla.com:9200/_cluster/allocation/explain?pretty=true"

curl -X PUT -H "Content-Type: application/json" gradbsev2integr01.int.nabla.com:9200/_cluster/settings -d '{
    "transient" : {
        "cluster.routing.allocation.disk.threshold_enabled" : false
    }
}'

curl -X PUT -H "Content-Type: application/json" gra1sedev1.int.nabla.com:9200/_cluster/settings -d '{
    "persistent" : {
        "action.auto_create_index" : false
    }
}'

curl -X PUT -H "Content-Type: application/json" gra1seingest1.int.nabla.com:9200/_cluster/settings -d '{
	"transient" : {
		"cluster.routing.allocation.disk.threshold_enabled" : true
	}
}'

curl -X PUT -H "Content-Type: application/json" gradbsev2integr01.int.nabla.com:9200/_cluster/settings -d '{
    "persistent" : {
        "action.auto_create_index" : true
    }
}'

# Remove failed index
rm -Rf /usr/share/elasticsearch/data/nodes/0/indices/Sl_NtK3VSjykU77eZZSTBw

# ssh grasev2preprod01

elasticsearch-plugin install analysis-icu
docker-compose up logstash mapping

# Add https://www.elastic.co/guide/en/beats/metricbeat/7.12/metricbeat-installation-configuration.html
curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.12.1-amd64.deb
sudo dpkg -i metricbeat-7.12.1-amd64.deb

sudo metricbeat modules enable elasticsearch-xpack
sudo nano /etc/metricbeat/metricbeat.yml
sudo service metricbeat start

sudo iptables -A INPUT -p tcp -s 10.20.0.0/24 --dport 9200 -j ACCEPT

# See monitoring
# http://gradbsev2integr01.int.nabla.com:5601/app/monitoring
http://elastic:xxxxxx@es-search-engine.service.gra.prod.consul:9200/_cluster/health

# Upgrading elastic search from 1 to 8
# See https://mpolinowski.github.io/docs/DevOps/Elasticsearch/2022-02-02--elasticsearch-v8-upgrade/2022-02-02/

# Create kibana service token
/usr/share/elasticsearch/bin/elasticsearch-service-tokens create elastic/kibana dashboard

# /usr/share/elasticsearch/bin/elasticsearch-service-tokens delete elastic/kibana dashboard
/usr/share/elasticsearch/bin/elasticsearch-service-tokens list

# NOK /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana

# curl -H "Authorization: Bearer ${SERVICE_TOKEN_DEV}" http://es-assistant-user-upload.service.gra.dev.consul -f:9200/_security/_authenticate?pretty
curl -H "Authorization: Bearer ${SERVICE_TOKEN_DEV}" http://es-assistant-user-upload.service.gra.dev.consul -f:80/_security/_authenticate?pretty
curl -X GET -k -H "Authorization: Bearer ${SERVICE_TOKEN_DEV}" "http://10.30.0.115:27041/_security/_authenticate"

curl -k -H "Authorization: Bearer ${SERVICE_TOKEN_DEV}" -XGET 'https://es-assistant-user-upload.service.gra.dev.consul/_cat/indices?s=index&v=true'

# https://www.elastic.co/guide/en/elasticsearch/reference/current/reset-password.html
bin/elasticsearch-reset-password -u elastic
bin/elasticsearch-reset-password --batch --user kibana_system
# bin/elasticsearch-setup-passwords auto -u "http://localhost:9201"

curl -k -X POST -u ${ELASTICSEARCH_USERNAME}:${ELASTICSEARCH_PASSWORD_DEV} -XGET 'https://es-assistant-user-upload.service.gra.dev.consul/_cat/indices?s=index&v=true'

# https://www.elastic.co/guide/en/kibana/current/index-patterns-api-create.html

curl -k -u ${ELASTICSEARCH_USERNAME}:${ELASTICSEARCH_PASSWORD_DEV} -XPUT 'https://es-assistant-user-upload.service.gra.dev.consul/alban?pretty' -H 'Content-Type: application/json' -d'{"settings" : {"index" : {"number_of_shards" : 3, "number_of_replicas" : 0 }}}'

exit 0
