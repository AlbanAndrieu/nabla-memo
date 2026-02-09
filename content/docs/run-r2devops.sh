#!/bin/bash
set -xv

# https://docs.r2devops.io/docs/self-managed/local-docker-compose

cd /home/albandrieu/w/follow
git clone https://github.com/r2devops/self-managed.git r2devops
cd r2devops
docker compose -f compose.local.yml up -d

exit 0
