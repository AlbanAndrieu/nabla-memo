#!/bin/bash
set -xv

# COPY index

curl -X PUT  -H "Content-Type: application/json"  gradbsev2integr01.int.nabla.com:9200/_cluster/settings -d '{
    "persistent" : {
        "action.auto_create_index" : true
    }
}'

nohup curl -X POST  -H "Content-Type: application/json"  http://gradbsev2integr01.int.nabla.com:9200/_reindex -d '{
  "source": {
    "index": "nablase"
  },
  "dest": {
    "index": "nablase-2024-10-31"
  }
}'
> ~/nablase-2024-10-31-1.out &


ssh gra1sedev1
sudo su - ubuntu
cd /var/www/es/v2-elasticsearch/

docker-compose ps
docker ps -a
# v2-elasticsearch_elasticsearch
docker exec -it 5f885458c13a bash

# install on all node
bin/elasticsearch-plugin install repository-s3

curl -X GET http://localhost:9200/_nodes?filter_path=nodes.*.plugins

bin/elasticsearch-plugin list

tf-se-es-backup-dev
elasticsearch-keystore remove s3.client.default.access_key
elasticsearch-keystore add s3.client.default.access_key
	XXX
elasticsearch-keystore remove s3.client.default.secret_key
elasticsearch-keystore add s3.client.default.secret_key
    XXX

elasticsearch-keystore list

curl -X POST "localhost:9200/_nodes/reload_secure_settings"

curl -X POST  -H "Content-Type: application/json"  http://localhost:9200/_snapshot/tf-se-es-backup-dev -d '{
  "type": "s3",
  "settings": {
    "bucket": "tf-se-es-backup-dev",
    "endpoint": "https://s3.gra.io.cloud.ovh.net/",
    "base_path": "path"
  }
}'

curl -X POST  -H "Content-Type: application/json"  http://localhost:9200/_snapshot/tf-se-es-backup-uat -d '{
  "type": "s3",
  "settings": {
    "bucket": "tf-se-es-backup-uat",
    "endpoint": "https://s3.gra.io.cloud.ovh.net/",
    "base_path": "path"
  }
}'

daily-snapshots
<daily-snap-{now/d}>

curl -X POST  -H "Content-Type: application/json"  http://localhost:9200/_snapshot/tf-se-es-backup-dev/daily-snap-2025.05.25-XX-XX-XX/_restore -d '{
  "indices": "nablase",
  "ignore_unavailable": true,
  "include_global_state": false,
  "include_aliases": true
}'

exit 0
