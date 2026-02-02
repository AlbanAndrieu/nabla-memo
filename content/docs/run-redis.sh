#!/bin/bash
set -xv
sudo apt install redis-tools
redis-cli
FLUSHDB - Removes data from your connections CURRENT database.
FLUSHALL - Removes data from ALL databases.
sudo sysctl vm.overcommit_memory=1
systemctl status redis-server.service
redis-cli
info
info clients
slowlog get 2
tail -f /var/log/redis/redis-server.log
docker pull redis:7.8.4
./run-flatpak.sh
flatpak install flathub app.resp.RESP
flatpak run app.resp.RESP
redis-cli -h redis.service.gra.uat.consul -p 80
redis-cli --no-auth-warning -h redis.service.gra.uat.consul -p 6379
redis-cli --no-auth-warning -h juicefs-redis.service.gra.dev.consul -p 6380
select 10
flushdb
redis-cli --no-auth-warning -h juicefs-redis.service.gra.dev.consul -p 6380 -n 10 flushdb
redis-cli
del key_customer_ip_*
redis-cli -u rediss://$JUICEFS_ADMIN_USER:$JUICEFS_ADMIN_PASSWORD@redis-b88d3294-o412bbed9.database.cloud.ovh.net:20185     ping
grafana-cli plugins install redis-datasource
grafana-cli plugins install redis-app
terraform import grafana_data_source.by_uid prometheus
systemctl restart redis-server.service
chmod 777 /etc/redis
chmod 664 /etc/redis/redis.conf
sudo mkdir /var/log/redis/
chmod 777 /var/log/redis/
sudo mkdir /var/lib/redis/
chmod 777 /var/lib/redis
redis-server --save "" --appendonly no
redis-cli config get save
redis-cli config set save ""
redis-cli config get loglevel
sudo service redis-server start
redis-cli -c -h localhost -p 6379
localhost:6379 > PING
PONG
nano /etc/redis/redis.conf
redis-cli --cluster fix 127.0.0.1:6379
sudo snap install another-redis-desktop-manager
exit 0
