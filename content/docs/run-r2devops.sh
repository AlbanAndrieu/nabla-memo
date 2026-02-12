#!/bin/bash
set -xv

# https://docs.r2devops.io/docs/self-managed/local-docker-compose

# cd /home/albandrieu/w/follow
# git clone https://github.com/r2devops/self-managed.git r2devops
# cd r2devops

# https://getplumber.io/docs/installation/docker-compose-local

echo "http://localhost:3002/"
echo "http://localhost:3001/api/auth/gitlab/callback"

docker compose -f compose.local.yml up -d

exit 0
