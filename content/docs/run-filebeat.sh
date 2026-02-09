#!/bin/bash
set -xv

curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.12.0-amd64.deb
sudo dpkg -i filebeat-7.12.0-amd64.deb

sudo systemctl status filebeat.service
sudo systemctl disable filebeat.service

# sudo apt remove filebeat

filebeat modules list

sudo filebeat modules enable system apache mysql

sudo filebeat setup
sudo service filebeat start

exit 0
