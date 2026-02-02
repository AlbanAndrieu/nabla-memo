#!/bin/bash
set -euo pipefail

# Prometheus Configuration and Management Script
# See https://prometheus.io/docs/instrumenting/exporters/

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Note: PROMETHEUS_ADDR variables are for reference/documentation purposes
# They can be used in manual commands below
PROMETHEUS_ADDR="${PROMETHEUS_ADDR:-http://localhost:9090}"
PROMETHEUS_ADDR_DEV="${PROMETHEUS_ADDR_DEV:-http://localhost:9090}"
DEBUG="${DEBUG:-0}"

# Enable debug mode if DEBUG is set
if [[ "${DEBUG}" == "1" ]]; then
    set -xv
fi

# Trap handler for errors
trap 'echo "❌ Error on line ${LINENO}" >&2' ERR

# See https://sbcode.net/prometheus/delete-timeseries/

curl -X POST -g 'http://localhost:9090/api/v1/admin/tsdb/delete_series?match[]=ALERTS'
curl -X POST -g 'http://localhost:9090/api/v1/admin/tsdb/delete_series?match[]=ALERTS_FOR_STATE'

curl -X POST -g ${PROMETHEUS_ADDR_DEV}/api/v1/admin/tsdb/delete_series?match[]=ALERTS_FOR_STATE
#curl -X POST -g 'http://10.30.0.91:9090/api/v1/admin/tsdb/delete_series?match[]={job="node_exporter"}' -v
curl -X POST -g 'http://10.30.0.91:9090/api/v1/label/__name__/valuesnomad_nomad_job_summary.*'
#curl -X POST -g 'http://prometheus.service.gra.dev.consul:9090/api/v1/admin/tsdb/delete_series?match[]=nomad_nomad_job_summary_failed'
curl -X POST -g 'http://10.30.0.91:9090/api/v1/admin/tsdb/delete_series?match[]=nomad_nomad_job_summary_failed' -v
curl -X POST -g 'http://10.30.0.91:9090/api/v1/admin/tsdb/delete_series' -d '{"matchers": [{"name": "__name__", "value": "up"}]}'

curl -X POST -g 'http://10.30.0.91:9090/api/v1/admin/tsdb/delete_series?match[]=up'
curl -X POST -g 'http://10.30.0.91:9090/api/v2/admin/tsdb/delete_series?match[]={instance="10.30.0.152:4646"}'

# https://faun.pub/how-to-drop-and-delete-metrics-in-prometheus-7f5e6911fb33

curl http://10.30.0.91:9090/api/v1/label/__name__/values | tr ',' '\n' | tr -d '"' | grep '^go_.*'
curl http://localhost:9090/api/v1/label/__name__/values | tr ',' '\n' | tr -d '"' | grep '^go_.*' >prom_go_metrics.txt

curl -XPOST http://10.30.0.91:9090/api/v1/admin/tsdb/clean_tombstones

#curl -d '[{"labels": {"Alertname": "PagerDuty Test"}}]' http://localhost:9093/api/v1/alerts
curl -d '[{"labels": {"Alertname": "PagerDuty Test"}}]' http://alertmanager.service.gra.prod.consul/api/v1/alerts

# AND restart

# Freenas

#https://collectd.org/wiki/index.php/Plugin:Write_Prometheus
#see http://192.168.1.24:9103/
#https://www.freebsd.org/cgi/man.cgi?query=prometheus_sysctl_exporter&apropos=0&sektion=8&manpath=FreeBSD+12-current&arch=default&format=html

sudo apt install python3-bcrypt

exit 0
