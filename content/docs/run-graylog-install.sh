#!/bin/bash
apt install apt-transport-https gnupg2 uuid-runtime pwgen curl dirmngr -y
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc|  gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse"|  tee /etc/apt/sources.list.d/mongodb-org-7.0.list
apt update
apt install mongodb-org -y
systemctl enable --now mongod
systemctl status mongod
apt install openjdk-11-jre-headless
java --version
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch|  gpg --dearmor -o /usr/share/keyrings/elastic-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/elastic-archive-keyring.gpg] https://artifacts.elastic.co/packages/oss-7.x/apt stable main"|  tee /etc/apt/sources.list.d/elastic-7.x.list
apt update
apt install elasticsearch-oss
systemctl daemon-reload
systemctl enable --now elasticsearch
systemctl status elasticsearch
curl -X GET http://localhost:9200
wget https://packages.graylog2.org/repo/packages/graylog-6.1-repository_latest.deb
dpkg -i graylog-6.1-repository_latest.deb
apt update
apt install graylog-server -y
                                            < /dev/urandom tr -dc A-Z-a-z-0-9|head -c${1:-96}
echo
echo -n "Enter Password: "&&  head -1 < /dev/stdin| tr -d '\n'|  sha256sum|  cut -d" " -f1
sudo geany /etc/graylog/server/server.conf
mongodb_uri = mongodb://localhost:27017/graylog
elasticsearch_hosts = http://127.0.0.1:9200
systemctl daemon-reload
systemctl enable --now graylog-server
systemctl status graylog-server
echo "http://localhost:9000/"
./run-freenas-graylog.sh
exit 0
