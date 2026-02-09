#!/bin/bash
set -xv

# https://www.crestdata.ai/data-sheet/pfsense-integration-with-datadog

# https://app.datadoghq.eu/apm/traces?query=service%3Acurl&agg_m=count&agg_m_source=base&agg_q=%40peer.hostname&agg_q_source=base&agg_t=count&cols=core_service%2Ccore_resource_name%2Clog_duration%2Clog_http.method%2Clog_http.status_code&fromUser=false&graphType=flamegraph&historicalData=true&messageDisplay=inline&refresh_mode=sliding&shouldShowLegend=true&sort=time&spanType=all&step=auto&storage=hot&target-span=a&top_n=30&top_o=top&tq_query_translation_version=v0&traceQuery=a&view=spans&viz=toplist&x_missing=true&start=1734101422389&end=1734105022389&paused=false

# https://app.datadoghq.eu/apm/traces?query=service%3Aguzzle&agg_m=%40duration&agg_m_source=base&agg_q=%40http.host&agg_q_source=base&agg_t=median&cols=core_service%2Ccore_resource_name%2Clog_duration%2Clog_http.method%2Clog_http.status_code&fromUser=false&historicalData=true&messageDisplay=inline&sort=desc&spanType=all&step=auto&storage=hot&top_n=10&top_o=top&view=spans&viz=timeseries&x_missing=true&start=1734101438678&end=1734105038678&paused=false

# https://docs.datadoghq.com/tracing/services/inferred_services/?tab=agentv7551#set-up-inferred-services
# compute_stats_by_span_kind: true
# peer_tags_aggregation: true

pkg install postgresql-contrib

# sudo service datadog-agent status
tail -f /var/log/datadog/agent.log
# on docker
agent status

npm install dd-trace

# https://docs.datadoghq.com/integrations/gunicorn/
sudo netstat -nup | grep "127.0.0.1:8125.*ESTABLISHED"

# https://github.com/DataDog/datadog-ci/tree/master/src/commands/git-metadata
# npm install --save-dev @datadog/datadog-ci
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
export # DD_SYSTEM_PROBE_NETWORK_ENABLED=true
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

export # DD_PROFILING_PYTORCH_ENABLED=true
export DD_TRACE_ENABLED=false
export DD_PROFILING_ENABLED=true
export DD_DYNAMIC_INSTRUMENTATION_ENABLED=true
export DD_API_SECURITY_ENABLED=true
export DD_APPSEC_ENABLED=false
export DD_APM_TRACING_ENABLED=true
export DD_LOGS_INJECTION=true

exit 0
