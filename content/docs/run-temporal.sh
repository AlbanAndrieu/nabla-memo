#!/bin/bash
set -xv

# local temporal : https://github.com/temporalio/temporal#download-and-start-temporal-server-locally

sudo snap install temporal
temporal server start-dev

temporal operator namespace list

# initialize

GRANT USAGE ON SCHEMA public TO temporal
GRANT ALL ON DATABASE temporal TO temporal
GRANT ALL ON DATABASE temporal_visibility TO temporal
REVOKE CREATE ON SCHEMA public FROM temporal

SQL_DATABASE=temporal
DEFAULT_SCHEMA_NAME=temporal
VISIBILITY_SCHEMA_NAME=temporal_visibility
# SKIP_DB_CREATE    = false
# SKIP_SCHEMA_SETUP = false

./run-go.sh

grpcurl --plaintext temporal-app.service.gra.${NOMAD_VAR_env}.consul:7233 describe
grpcurl --plaintext temporal-app.service.gra.${NOMAD_VAR_env}.consul:7233 list
# TODO grpcurl --insecure -v  otel-collector.service.gra.${NOMAD_VAR_env}.consul:4317 describe

brew install tctl
tctl --address temporal-app.service.gra.${NOMAD_VAR_env}.consul:7233 --namespace citation namespace register
export TEMPORAL_CLI_SHOW_STACKS=1
tctl --address temporal-app.service.gra.${NOMAD_VAR_env}.consul:7233 --context_timeout 45 namespace list

tctl --address temporal-app.service.gra.${NOMAD_VAR_env}.consul:7233 cluster health

# docker run --network=host --rm temporalio/tctl:1.13.0  --address temporal-app.service.gra.dev.consul:7233  --namespace samples-namespace namespace describe
docker run --rm -it --entrypoint tctl --network host --env TEMPORAL_CLI_ADDRESS=temporal-app.service.gra.${NOMAD_VAR_env}.consul:7233 temporalio/admin-tools:1.14.0 --namespace samples-namespace namespace describe

# temporal workflow terminate -w ebb2e0b6-70b9-40c7-af80-fcb662f5d887 --namespace citation
tctl --address temporal-app.service.gra.${NOMAD_VAR_env}.consul:7233 taskqueue describe --taskqueue citation

tctl --address temporal-app.service.gra.${NOMAD_VAR_env}.consul:7233
tctl --address temporal-app.service.gra.${NOMAD_VAR_env}.consul:7233 --namespace citation workflow list
tctl --address temporal-app.service.gra.${NOMAD_VAR_env}.consul:7233 --namespace citation workflow reset -w d2ebe203-0eea-4925-b5ca-fdb686e05967 --reason 'Alban ask it' --reset_type LastWorkflowTask
tctl --address temporal-app.service.gra.${NOMAD_VAR_env}.consul:7233 --namespace citation workflow terminate -w a86530aa-907c-4736-ac3c-899b5d01ee84

tctl --address temporal-app.service.gra.${NOMAD_VAR_env}.consul:7233 namespace update --retention 15
tctl --address temporal-app.service.gra.${NOMAD_VAR_env}.consul:7233 namespace update --history_archival_state enabled
tctl --address temporal-app.service.gra.${NOMAD_VAR_env}.consul:7233 namespace update --visibility_archival_state enabled

exit 0
