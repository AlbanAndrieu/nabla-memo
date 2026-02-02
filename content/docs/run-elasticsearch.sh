#!/bin/bash
set -xv
sudo apt remove elastic*
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch|  sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
sudo apt-get install apt-transport-https
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main"|  sudo tee /etc/apt/sources.list.d/elastic-8.x.list
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/9.x/apt stable main"|  sudo tee /etc/apt/sources.list.d/elastic-9.x.list
sudo apt-get update&&  sudo apt-get install elasticsearch elasticsearch-curator
sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic
sudo systemctl enable --now elasticsearch.service
sudo systemctl start elasticsearch.service
sudo systemctl stop elasticsearch.service
sudo usermod -a -G elasticsearch kibana
sudo systemctl restart kibana.service
sudo journalctl -u kibana
curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic https://localhost:9200
curl -XGET 'localhost:9200/_cat/nodes?v&pretty'
http://localhost:9200/_plugin/gui/index.html
cd /usr/share/elasticsearch/bin
sudo ./plugin remove royrusso/elasticsearch-HQ
sudo ./plugin install royrusso/elasticsearch-HQ
echo http://localhost:9200/_plugin/HQ/
tail -f /var/log/elasticsearch/elasticsearch.log
ll /var/lib/elasticsearch/elasticsearch/nodes/
ls /var/lib/elasticsearch/nodes
sudo nano /etc/sysctl.conf
vm.max_map_count=262144
mkdir /data/elasticsearch/
cd /data/elasticsearch/
cd /usr/share/elasticsearch/
sudo ln -s /data/elasticsearch/data data
sudo nano /etc/elasticsearch/elasticsearch.yml
curl -X POST -u elastic:xxxxxxx "http://localhost:9200/_cluster/reroute?retry_failed=true"
curl -X POST "http://jaeger-elasticsearch.service.gra.uat.consul/_cluster/reroute?retry_failed=true"
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
rm -Rf /usr/share/elasticsearch/data/nodes/0/indices/Sl_NtK3VSjykU77eZZSTBw
elasticsearch-plugin install analysis-icu
docker-compose up logstash mapping
curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.12.1-amd64.deb
sudo dpkg -i metricbeat-7.12.1-amd64.deb
sudo metricbeat modules enable elasticsearch-xpack
sudo nano /etc/metricbeat/metricbeat.yml
sudo service metricbeat start
sudo iptables -A INPUT -p tcp -s 10.20.0.0/24 --dport 9200 -j ACCEPT
http://elastic:xxxxxx@es-search-engine.service.gra.prod.consul:9200/_cluster/health
/usr/share/elasticsearch/bin/elasticsearch-service-tokens create elastic/kibana dashboard
/usr/share/elasticsearch/bin/elasticsearch-service-tokens list
curl -H "Authorization: Bearer $SERVICE_TOKEN_DEV"   http://es-assistant-user-upload.service.gra.dev.consul -f:80/_security/_authenticate?pretty
curl -X GET -k -H "Authorization: Bearer $SERVICE_TOKEN_DEV"   "http://10.30.0.115:27041/_security/_authenticate"
curl -k -H "Authorization: Bearer $SERVICE_TOKEN_DEV"   -XGET 'https://es-assistant-user-upload.service.gra.dev.consul/_cat/indices?s=index&v=true'
bin/elasticsearch-reset-password -u elastic
bin/elasticsearch-reset-password --batch --user kibana_system
curl -k -X POST -u $ELASTICSEARCH_USERNAME:$ELASTICSEARCH_PASSWORD_DEV     -XGET 'https://es-assistant-user-upload.service.gra.dev.consul/_cat/indices?s=index&v=true'
curl -k -u $ELASTICSEARCH_USERNAME:$ELASTICSEARCH_PASSWORD_DEV     -XPUT 'https://es-assistant-user-upload.service.gra.dev.consul/alban?pretty' -H 'Content-Type: application/json' -d'{"settings" : {"index" : {"number_of_shards" : 3, "number_of_replicas" : 0 }}}'
exit 0
