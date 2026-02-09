#!/bin/bash
set -xv

./run-gitlab.sh

geany /home/albandrieu/.gitlab-runner/config.toml
# listen_address = ":9252"
curl -s "http://localhost:9252/metrics" | grep -E "# HELP"
# sudo ufw allow 9252
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 9252 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 8093 -j ACCEPT

curl -s "http://gragitrunner01.int.jusmundi.com:9252/metrics" | grep -E "# HELP"
curl -s "http://grabackprod01.int.jusmundi.com:9252/metrics" | grep -E "# HELP"

# curl -s "http://gragitrunner01.int.jusmundi.com:9252/metrics" | grep -E "# HELP"
# curl -s "http://grabackprod01.int.jusmundi.com:9252/metrics" | grep -E "# HELP"
# - job_name: 'gitlab-runner'
#   # scrape_interval: 15s
#   metrics_path: /metrics
#   static_configs:
#     - targets: ['gragitrunner01.int.jusmundi.com:9252']
#       labels:
#         group: 'telemetry'
#         env: '${var.env}'
#     - targets: ['grabackprod01.int.jusmundi.com:9252']
#       labels:
#         group: 'telemetry'
#         env: '${var.env}'
#   relabel_configs:
#     - source_labels: ['__meta_consul_node']
#       regex:         '(.*)'
#       target_label:  'env'
#       replacement:   '${var.env}'
#     - source_labels: ['__meta_consul_node']
#       regex:         '(.*)'
#       target_label:  'group'
#       replacement:   'telemetry'

exit 0
