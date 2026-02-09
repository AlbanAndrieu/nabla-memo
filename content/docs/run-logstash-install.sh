#!/bin/bash
set -xv

#wget --quiet --output-document=- https://artifacts.elastic.co/GPG-KEY-elasticsearch | gpg --dearmor | sudo tee /usr/share/keyrings/elasticsearch-archive-keyring.gpg
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

sudo apt install logstash
systemctl enable logstash
sudo service logstash status

exit 0
