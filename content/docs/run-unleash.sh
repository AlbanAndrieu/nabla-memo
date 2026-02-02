#!/bin/bash
set -xv
docker run \
  -e UNLEASH_PROXY_SECRETS=alban123 \
  -e UNLEASH_URL=https://gitlab.com/api/v4/feature_flags/unleash/46788175 \
  -e UNLEASH_INSTANCE_ID=$UNLEASH_INSTANCE_ID \
  -e UNLEASH_APP_NAME=staging \
  -e UNLEASH_API_TOKEN=$UNLEASH_API_TOKEN \
  -p 3000:3000 \
  unleashorg/unleash-proxy
exit 0
