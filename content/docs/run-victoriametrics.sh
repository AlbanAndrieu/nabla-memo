#!/bin/bash
set -xv
export VICTORIAMETRICS_METRIC_NAME="request_size_byte"
export VICTORIAMETRICS_METRIC_NAME="time_ms_duration"
export VICTORIAMETRICS_METRIC_NAME="time_ms_summary"
export VICTORIAMETRICS_METRIC_NAME="client_ip_response_total"
export VICTORIAMETRICS_METRIC_NAME="http_endpoint"
export VICTORIAMETRICS_METRIC_NAME="http_status_jm_client_ip"
export VICTORIAMETRICS_METRIC_NAME="http_request_duration_seconds"
time_ms_summary
time_ms_histogram
time_ms_duration
request_size_byte
client_ip_response_total
container_tasks_state
container_memory_failures_total
consul_health_service_status
consul_service_tag
curl -v -u $VICTORIAMETRICS_USER:$VICTORIAMETRICS_PASSWORD     -s http://victoriametrics.service.gra.$NOMAD_VAR_env.consul/api/v1/admin/tsdb/delete_series?match[]=$VICTORIAMETRICS_METRIC_NAME
curl -v -u $VICTORIAMETRICS_USER:$VICTORIAMETRICS_PASSWORD     -s http://victoriametrics.service.gra.$NOMAD_VAR_env.consul/api/v1/admin/tsdb/delete_series?match[]=$VICTORIAMETRICS_METRIC_NAME
curl -v -u $VICTORIAMETRICS_USER:$VICTORIAMETRICS_PASSWORD     -s http://victoriametrics.service.gra.$NOMAD_VAR_env.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_bucket
curl -v -u $VICTORIAMETRICS_USER:$VICTORIAMETRICS_PASSWORD     -s http://victoriametrics.service.gra.$NOMAD_VAR_env.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_count
curl -v -u $VICTORIAMETRICS_USER:$VICTORIAMETRICS_PASSWORD     -s http://victoriametrics.service.gra.$NOMAD_VAR_env.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_sum
curl -v -u $VICTORIAMETRICS_USER:$VICTORIAMETRICS_PASSWORD     -s http://victoriametrics.service.gra.$NOMAD_VAR_env.consul/api/v1/admin/tsdb/delete_series?match[]=$VICTORIAMETRICS_METRIC_NAME
curl -v -u $VICTORIAMETRICS_USER:$VICTORIAMETRICS_PASSWORD     -s http://victoriametrics.service.gra.$NOMAD_VAR_env.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_avg
curl -v -u $VICTORIAMETRICS_USER:$VICTORIAMETRICS_PASSWORD     -s http://victoriametrics.service.gra.$NOMAD_VAR_env.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_count
curl -v -u $VICTORIAMETRICS_USER:$VICTORIAMETRICS_PASSWORD     -s http://victoriametrics.service.gra.$NOMAD_VAR_env.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_sum
curl -v -u $VICTORIAMETRICS_USER:$VICTORIAMETRICS_PASSWORD     -s http://victoriametrics.service.gra.$NOMAD_VAR_env.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_min
curl -v -u $VICTORIAMETRICS_USER:$VICTORIAMETRICS_PASSWORD     -s http://victoriametrics.service.gra.$NOMAD_VAR_env.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_max
curl -v -X POST http://victoriametrics.service.gra.$NOMAD_VAR_env.consul/internal/force_merge
exit 0
