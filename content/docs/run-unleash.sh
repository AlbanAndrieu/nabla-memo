#!/bin/bash
set -xv

# See proxy https://docs.getunleash.io/reference/unleash-proxy#how-to-connect-to-the-proxy

docker run \
  -e UNLEASH_PROXY_SECRETS=alban123 \
  -e UNLEASH_URL=https://gitlab.com/api/v4/feature_flags/unleash/46788175 \
  -e UNLEASH_INSTANCE_ID=${UNLEASH_INSTANCE_ID} \
  -e UNLEASH_APP_NAME=staging \
  -e UNLEASH_API_TOKEN=${UNLEASH_API_TOKEN} \
  -p 3000:3000 \
  unleashorg/unleash-proxy

# NOK curl --head -H "Authorization:$UNLEASH_API_TOKEN" https://gitlab.com/api/v4/feature_flags/unleash/46788175
# NOK curl -XGET https://gitlab.com/api/v4/projects/46788175/feature_flags/admin_panel

exit 0
