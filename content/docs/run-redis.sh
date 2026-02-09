#!/bin/bash
set -xv

sudo apt install redis-tools

#empty redis database
redis-cli
#With redis-cli:

FLUSHDB - Removes data from your connections CURRENT database.
FLUSHALL - Removes data from ALL databases.

sudo sysctl vm.overcommit_memory=1

systemctl status redis-server.service

redis-cli
info
info clients
slowlog get 2

#log
tail -f /var/log/redis/redis-server.log

#docker pull redislabs/redisinsight:latest
docker pull redis:7.8.4

# Install redis tool : https://redis.io/docs/tools/

# UI Tool : https://github.com/uglide/RedisDesktopManager
./run-flatpak.sh

flatpak install flathub app.resp.RESP
flatpak run app.resp.RESP

# redis://redis.service.gra.uat.consul:6379

redis-cli -h redis.service.gra.uat.consul -p 80
redis-cli --no-auth-warning -h redis.service.gra.uat.consul -p 6379 # -a 'password'

# juicefs cleaning
redis-cli --no-auth-warning -h juicefs-redis.service.gra.dev.consul -p 6380
select 10
flushdb

redis-cli --no-auth-warning -h juicefs-redis.service.gra.dev.consul -p 6380 -n 10 flushdb

redis-cli
del key_customer_ip_*

# redis-cli --no-auth-warning -h redis-b88d3294-o412bbed9.database.cloud.ovh.net -p 20185 --user jusmundiadmin --pass
redis-cli -u rediss://${JUICEFS_ADMIN_USER}:${JUICEFS_ADMIN_PASSWORD}@redis-b88d3294-o412bbed9.database.cloud.ovh.net:20185 ping

grafana-cli plugins install redis-datasource
grafana-cli plugins install redis-app
#grafana-cli plugins install redis-explorer-app

terraform import grafana_data_source.by_uid prometheus

systemctl restart redis-server.service

# Fix start
chmod 777 /etc/redis
chmod 664 /etc/redis/redis.conf
sudo mkdir /var/log/redis/
#NOK sudo chown redis:redis /var/log/redis/
chmod 777 /var/log/redis/
sudo mkdir /var/lib/redis/
chmod 777 /var/lib/redis

# see https://medium.com/the-metricfire-blog/how-to-monitor-redis-performance-819125702401
# https://github.com/oliver006/redis_exporter

# MISCONF Redis is configured to save RDB snapshots
# redis-cli config set stop-writes-on-bgsave-error no
# redis-cli config set auto-aof-rewrite-percentage 0
redis-server --save "" --appendonly no
redis-cli config get save
redis-cli config set save ""

# AOF is not enabled, you may lose data if Redis is not shutdown properly.
redis-cli config get loglevel

# Redis Cluster cannot be connected. Please provide at least one reachable node: Cluster mode is not enabled on this node
# Fix redis cluster : All slots are not covered after query all startup_nodes

sudo service redis-server start

redis-cli -c -h localhost -p 6379
localhost:6379> PING
PONG

nano /etc/redis/redis.conf
# cluster-enabled yes
redis-cli --cluster fix 127.0.0.1:6379

# export REDIS_HOST=localhost

# https://snapcraft.io/install/another-redis-desktop-manager/ubuntu#install
sudo snap install another-redis-desktop-manager

exit 0
