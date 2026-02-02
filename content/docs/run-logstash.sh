#!/bin/bash
set -xv
sudo service elasticsearch status
sudo service logstash start
sudo service apache2 start
sudo a2dissite 000-default
sudo a2dissite kibana3
sudo a2ensite elasticsearch
service apache2 reload
http://localhost:9200/
http://localhost:7070/elasticsearch
http://localhost:7070/kibana
http://localhost/
http://localhost:9292/
usermod -a -G adm logstash
groups logstash
id logstash
find /var/log -user root -perm 0600
less /etc/init/logstash.conf
sudo -u logstash /opt/logstash/bin/logstash agent -f /etc/logstash/conf.d -l /var/log/logstash/logstash.log
sudo service logstash-web stop
sudo tail -f /var/log/upstart/logstash.log
sudo tail -f /var/log/logstash/logstash.log
Installing apache2-utils because htpasswd is so easy to use. This section creates kibana.htpassword for access to Kibana / Elasticsearch
sudo apt-get install apache2-utils
sudo htpasswd -c /etc/nginx/conf.d/kibana.htpasswd albandri
sudo htpasswd /etc/nginx/conf.d/kibana.htpasswd user
sudo htpasswd -c /etc/nginx/conf.d/kibana-write.htpasswd albandri
curl -XGET 'localhost:9200/_cat/nodes?v&pretty'
The following command remove's ES' built-in replication:
curl -XPUT 'localhost:9200/_settings' -d '
{
    "index" : {
        "number_of_replicas" : 0
      }
}
'
sudo service redis-server start
tail -f /var/log/redis/redis-server.log
nano /etc/elasticsearch/elasticsearch.yml
curl -X PUT http://localhost:9200/kibana-int/dashboard/collectd-overview -T /workspace/users/albandri10/env/ansible-nabla/roles/alban.andrieu.logstash-settings/files/collectd-overview.json
wget https://gist.githubusercontent.com/shreyu86/8b9bb29d758d4ec5ce7c/raw/35d5c67181214fe65924d4f8147bcff8df73b3da/logstash.conf
docker run -d --name logstash --link es:elasticsearch logstash -v /tmp/logstash.conf:./logstash.conf logstash logstash -f ./logstash.conf
LOGSTASH_ADDRESS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' logstash)
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.3.0-amd64.deb
sudo dpkg -i filebeat-6.3.0-amd64.deb
docker pull docker.elastic.co/beats/filebeat:6.3.0
sudo filebeat setup --dashboards
docker exec -u 0 -it test_frmb_1 env TERM=xterm-256color bash -l
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.3-x86_64.rpm
rpm -vi filebeat-6.2.3-x86_64.rpm
curl -L -O https://artifacts.elastic.co/downloads/logstash/logstash-5.5.2.rpm
sudo rpm -vi logstash-5.5.2.rpm
sudo yum install libpcap
curl -L -O https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-5.5.2-x86_64.rpm
sudo rpm -vi packetbeat-5.5.2-x86_64.rpm
curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.5.2-x86_64.rpm
sudo rpm -vi metricbeat-5.5.2-x86_64.rpm
