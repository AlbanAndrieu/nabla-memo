#!/bin/bash
set -xv
echo "deb https://packages.grafana.com/oss/deb stable main"|  sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get install grafana-enterprise
grafana-cli -v
rm -Rf /var/lib/grafana/plugins
rm -Rf /var/lib/grafana/plugins/natel-discrete-panel
cd /usr/share/grafana
grafana-cli plugins install grafana-worldmap-panel
grafana-cli plugins install savantly-heatmap-panel
grafana cli plugins install grafana-piechart-panel
grafana cli plugins install grafana-clock-panel
grafana cli plugins install natel-discrete-panel
grafana cli plugins install redis-datasource
grafana cli plugins install redis-app
grafana-cli plugins install camptocamp-prometheus-alertmanager-datasource
grafana cli plugins install alexanderzobnin-zabbix-app
grafana cli plugins update-all
grafana server restart
nomad system gc
sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl start grafana-server
sudo systemctl --type=service --state=active|  grep grafana
wget https://grafana.com/api/dashboards/367/revisions/3/download
cd /mnt/data/nomad/grafana/plugins/
cd /var/lib/grafana/plugins
wget https://github.com/denniskniep/grafana-datasource-plugin-neo4j/releases/download/v1.1.0/kniepdennis-neo4j-datasource-1.1.0.zip
sudo unzip kniepdennis-neo4j-datasource-1.1.0.zip
ls -lrta /etc/grafana/provisioning/dashboards/
exit 0
