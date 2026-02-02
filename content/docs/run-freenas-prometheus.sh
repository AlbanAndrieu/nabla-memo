#!/bin/bash
set -xv
pkg install prometheus node_exporter
sysrc prometheus_enable=YES
sysrc node_exporter_enable=YES
edit /usr/local/etc/prometheus.yml
----------
- job_name: "node-exporter-local"
scrape_interval: 5s
static_configs:
- targets: ["localhost:9100"]
- job_name: 'node-exporter'
consul_sd_configs:
- server: '172.17.0.55:8500'
services: ['node-exporter']
relabel_configs:
- source_labels: ['__meta_consul_node']
regex: '(.*)'
target_label: 'env'
replacement: 'nabla'
- source_labels: ['__meta_consul_node']
regex: '(.*)'
target_label: 'group'
replacement: 'telemetry'
- source_labels: [__meta_consul_node]
target_label: instance
- job_name: "redis_exporter"
scrape_interval: 5s
static_configs:
- targets: ["172.17.0.55:9121"]
- job_name: 'haproxy-exporter'
consul_sd_configs:
- server: '172.17.0.55:8500'
services: ['haproxy-exporter']
relabel_configs:
- source_labels: ['__meta_consul_node']
regex: '(.*)'
target_label: 'env'
replacement: 'nabla'
- source_labels: ['__meta_consul_node']
regex: '(.*)'
target_label: 'group'
replacement: 'telemetry'
- source_labels: [__meta_consul_node]
target_label: instance
-------
service prometheus start
service node_exporter start
pkg install blackbox_exporter
pkg install snmp_exporter
echo "http://172.17.0.96:9090/"
pkg install alertmanager
sysrc alertmanager_enable=YES
service alertmanager start
echo "http://172.17.0.96:9093/"
exit 0
