#!/bin/bash
set -xv
sudo dpkg -i elasticsearch-5.1.1.deb
sudo service elasticsearch start
sudo dpkg -i haka_0.3.0_amd64.deb
sudo dpkg -i hakabana_0.2.1_all.deb
sudo dpkg -i haka-geoip_0.3.0_amd64.deb
sudo apt-get install libnetfilter-queue1
sudo dpkg -i haka-nfqueue_0.3.0_amd64.deb
sudo apt-get install libjansson4
sudo dpkg -i haka-elasticsearch_0.3.0_amd64.deb
sudo haka -c /usr/share/haka/hakabana/haka.conf
ll /usr/share/haka/hakabana/dashboard/Hakabana.json
curl -X PUT http://localhost:9200/kibana-int/dashboard/hakabana -d @Hakabana.json
curl -X PUT http://localhost:9200/.kibana/dashboard/hakabana -T /usr/share/haka/hakabana/dashboard/Hakabana.json
ll http://localhost:9200/kibana-int/dashboard/hakabana
curl -X PUT http://localhost:9200/kibana-int/dashboard/mydashboard -d @mydashboard.json
curl -X PUT http://localhost:9200/kibana-int/dashboard/mydashboard -T mydashboard.json
ll http://localhost:9200/kibana-int/dashboard/mydashboard
http://localhost:5601/app/kibana
