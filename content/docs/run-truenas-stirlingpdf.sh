#!/bin/bash
set -xv
cd /workspace/users/albandrieu30/nabla/infra/docker-compose
docker compose --env-file .env --env-file .env.secrets -f  docker-compose.yml up -d
echo "http://localhost:8085/"
exit 0
