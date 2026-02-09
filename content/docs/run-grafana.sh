#!/bin/bash
set -xv

#wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
#echo "deb https://packages.grafana.com/enterprise/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get install grafana-enterprise

grafana-cli -v

rm -Rf /var/lib/grafana/plugins
rm -Rf /var/lib/grafana/plugins/natel-discrete-panel

cd /usr/share/grafana

grafana-cli plugins install grafana-worldmap-panel
grafana-cli plugins install savantly-heatmap-panel
# See http://grafana.service.gra.uat.consul/plugins/grafana-piechart-panel
grafana cli plugins install grafana-piechart-panel
grafana cli plugins install grafana-clock-panel
grafana cli plugins install natel-discrete-panel

# TODO http://grafana.service.gra.prod.consul/plugins/natel-discrete-panel

grafana cli plugins install redis-datasource
grafana cli plugins install redis-app
#grafana cli plugins install redis-explorer-app

grafana-cli plugins install camptocamp-prometheus-alertmanager-datasource
grafana cli plugins install alexanderzobnin-zabbix-app

grafana cli plugins update-all

grafana server restart

# NOK grafana-cli plugins uninstall grafana-image-renderer
#ssh gra1nomadworkerdev1  sudo rm -Rf /mnt/data/nomad/grafana/plugins/grafana-image-renderer/
nomad system gc

sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl start grafana-server
sudo systemctl --type=service --state=active | grep grafana

# See https://grafana.com/docs/grafana/v7.5/administration/provisioning/#dashboards
# With ansible https://github.com/cloudalchemy/ansible-grafana

# haproxy grafana dashboard
# Below not working using id
# https://grafana.com/grafana/dashboards/367
# Need version 3
wget https://grafana.com/api/dashboards/367/revisions/3/download

# https://grafana.com/grafana/dashboards/6278
# consul https://grafana.com/grafana/dashboards/10642

# grafana-cli admin reset-admin-password password

# http://grafana.service.gra.dev.consul/plugins/kniepdennis-neo4j-datasource

cd /mnt/data/nomad/grafana/plugins/
cd /var/lib/grafana/plugins
wget https://github.com/denniskniep/grafana-datasource-plugin-neo4j/releases/download/v1.1.0/kniepdennis-neo4j-datasource-1.1.0.zip
sudo unzip kniepdennis-neo4j-datasource-1.1.0.zip

#grafana-cli plugins install  neo4j-datasource-plugin

ls -lrta /etc/grafana/provisioning/dashboards/

exit 0
