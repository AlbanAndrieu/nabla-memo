#!/bin/bash
set -xv

# https://docs.victoriametrics.com/guides/guide-delete-or-replace-metrics.html
# curl -s 'http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/series?match[]=time_ms_duration_bucket' | jq
# curl -s 'http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/admin/tsdb/delete_series?match[]=time_ms_duration_count'
# curl -s 'http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/admin/tsdb/delete_series?match[]=time_ms_duration_sum'

export VICTORIAMETRICS_METRIC_NAME="request_size_byte"
export VICTORIAMETRICS_METRIC_NAME="time_ms_duration"
export VICTORIAMETRICS_METRIC_NAME="time_ms_summary"
export VICTORIAMETRICS_METRIC_NAME="client_ip_response_total"
export VICTORIAMETRICS_METRIC_NAME="http_endpoint"
export VICTORIAMETRICS_METRIC_NAME="http_status_jm_client_ip"
export VICTORIAMETRICS_METRIC_NAME="http_request_duration_seconds"

# summary
time_ms_summary
# histogram
time_ms_histogram
time_ms_duration
request_size_byte
# counter
client_ip_response_total

# http_request_duration_seconds
# http_request_duration_seconds_summary
# {__name__="http_request_duration_seconds_bucket"}
# http_endpoint

container_tasks_state
container_memory_failures_total
consul_health_service_status
consul_service_tag

# curl -u ${VICTORIAMETRICS_USER}:${VICTORIAMETRICS_PASSWORD} -s http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/labels
# curl -u ${VICTORIAMETRICS_USER}:${VICTORIAMETRICS_PASSWORD} -s http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/query?query=${VICTORIAMETRICS_METRIC_NAME}&time=2023-02-22T19:10:30.781Z
# curl -u ${VICTORIAMETRICS_USER}:${VICTORIAMETRICS_PASSWORD} -s http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/query?query=up&time=2015-07-01T20:10:51.781Z

# counter
curl -v -u ${VICTORIAMETRICS_USER}:${VICTORIAMETRICS_PASSWORD} -s http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}

# histogram
curl -v -u ${VICTORIAMETRICS_USER}:${VICTORIAMETRICS_PASSWORD} -s http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}
curl -v -u ${VICTORIAMETRICS_USER}:${VICTORIAMETRICS_PASSWORD} -s http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_bucket
curl -v -u ${VICTORIAMETRICS_USER}:${VICTORIAMETRICS_PASSWORD} -s http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_count
curl -v -u ${VICTORIAMETRICS_USER}:${VICTORIAMETRICS_PASSWORD} -s http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_sum

# summary
curl -v -u ${VICTORIAMETRICS_USER}:${VICTORIAMETRICS_PASSWORD} -s http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}
curl -v -u ${VICTORIAMETRICS_USER}:${VICTORIAMETRICS_PASSWORD} -s http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_avg
curl -v -u ${VICTORIAMETRICS_USER}:${VICTORIAMETRICS_PASSWORD} -s http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_count
curl -v -u ${VICTORIAMETRICS_USER}:${VICTORIAMETRICS_PASSWORD} -s http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_sum
curl -v -u ${VICTORIAMETRICS_USER}:${VICTORIAMETRICS_PASSWORD} -s http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_min
curl -v -u ${VICTORIAMETRICS_USER}:${VICTORIAMETRICS_PASSWORD} -s http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/api/v1/admin/tsdb/delete_series?match[]=${VICTORIAMETRICS_METRIC_NAME}_max

curl -v -X POST http://victoriametrics.service.gra.${NOMAD_VAR_env}.consul/internal/force_merge

# https://faun.pub/specific-scrape-job-metrics-in-prometheus-remote-write-a139d36c2a6

exit 0
