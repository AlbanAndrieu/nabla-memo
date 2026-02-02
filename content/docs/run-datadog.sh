#!/bin/bash
set -xv
pkg install postgresql-contrib
tail -f /var/log/datadog/agent.log
agent status
npm install dd-trace
sudo netstat -nup|  grep "127.0.0.1:8125.*ESTABLISHED"
npm install -g @datadog/datadog-ci
datadog-ci git-metadata upload
nano /etc/datadog-agent/conf.d/apache.d/auto_conf.yaml
- apache_status_url: http://back-status.service.gra.dev.consul/server-status?auto
cp /etc/datadog-agent/conf.d/redisdb.d/conf.yaml.example /etc/datadog-agent/conf.d/redisdb.d/conf.yaml
nano /etc/datadog-agent/conf.d/redisdb.d/conf.yaml
- host: redis.service.gra.dev.consul
nano /etc/datadog-agent/system-probe.yaml
system_probe_config:
process_config:
enabled: true
sudo geany /etc/datadog-agent/datadog.yaml
logs_enabled
-------------
export DD_API_KEY=XXX
export
export DD_SITE=datadoghq.eu
export DD_REMOTE_CONFIGURATION_ENABLED=true
export DD_PROCESS_CONFIG_PROCESS_COLLECTION_ENABLED=true
export DD_PROCESS_AGENT_ENABLED=true
export DD_APM_ENABLED=true
export DD_APM_NON_LOCAL_TRAFFIC=true
export DD_AGENT_HOST=172.17.57
export DD_TRACE_AGENT_PORT=8126
export DD_ENV="freenas"
export DD_SERVICE="heimdall"
export DD_VERSION="1.0.0"
export DD_OTLP_CONFIG_RECEIVER_PROTOCOLS_GRPC_ENDPOINT=0.0.0.0:4317
export DD_OTLP_CONFIG_RECEIVER_PROTOCOLS_HTTP_ENDPOINT=0.0.0.0:4318
export DD_LOGS_ENABLED=true
export DD_OTLP_CONFIG_LOGS_ENABLED=true
export DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true
export DD_CONTAINER_EXCLUDE="name:datadog-agent"
export DD_SYSTEM_PROBE_PROCESS_SERVICE_INFERENCE_ENABLED=true
export
export DD_TRACE_ENABLED=false
export DD_PROFILING_ENABLED=true
export DD_DYNAMIC_INSTRUMENTATION_ENABLED=true
export DD_API_SECURITY_ENABLED=true
export DD_APPSEC_ENABLED=false
export DD_APM_TRACING_ENABLED=true
export DD_LOGS_INJECTION=true
exit 0
