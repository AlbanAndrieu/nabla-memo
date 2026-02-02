#!/bin/bash
set -xv
sudo snap install temporal
temporal server start-dev
temporal operator namespace list
GRANT USAGE ON SCHEMA public TO temporal
GRANT ALL ON DATABASE temporal TO temporal
GRANT ALL ON DATABASE temporal_visibility TO temporal
REVOKE CREATE ON SCHEMA public FROM temporal
SQL_DATABASE=temporal
DEFAULT_SCHEMA_NAME=temporal
VISIBILITY_SCHEMA_NAME=temporal_visibility
./run-go.sh
grpcurl --plaintext temporal-app.service.gra.$NOMAD_VAR_env.consul:7233   describe
grpcurl --plaintext temporal-app.service.gra.$NOMAD_VAR_env.consul:7233   list
brew install tctl
tctl --address temporal-app.service.gra.$NOMAD_VAR_env.consul:7233   --namespace citation namespace register
export TEMPORAL_CLI_SHOW_STACKS=1
tctl --address temporal-app.service.gra.$NOMAD_VAR_env.consul:7233   --context_timeout 45 namespace list
tctl --address temporal-app.service.gra.$NOMAD_VAR_env.consul:7233   cluster health
docker run --rm -it --entrypoint tctl --network host --env TEMPORAL_CLI_ADDRESS=temporal-app.service.gra.$NOMAD_VAR_env.consul:7233   temporalio/admin-tools:1.14.0 --namespace samples-namespace namespace describe
tctl --address temporal-app.service.gra.$NOMAD_VAR_env.consul:7233   taskqueue describe --taskqueue citation
tctl --address temporal-app.service.gra.$NOMAD_VAR_env.consul:7233
tctl --address temporal-app.service.gra.$NOMAD_VAR_env.consul:7233   --namespace citation workflow list
tctl --address temporal-app.service.gra.$NOMAD_VAR_env.consul:7233   --namespace citation workflow reset -w d2ebe203-0eea-4925-b5ca-fdb686e05967 --reason 'Alban ask it' --reset_type LastWorkflowTask
tctl --address temporal-app.service.gra.$NOMAD_VAR_env.consul:7233   --namespace citation workflow terminate -w a86530aa-907c-4736-ac3c-899b5d01ee84
tctl --address temporal-app.service.gra.$NOMAD_VAR_env.consul:7233   namespace update --retention 15
tctl --address temporal-app.service.gra.$NOMAD_VAR_env.consul:7233   namespace update --history_archival_state enabled
tctl --address temporal-app.service.gra.$NOMAD_VAR_env.consul:7233   namespace update --visibility_archival_state enabled
exit 0
