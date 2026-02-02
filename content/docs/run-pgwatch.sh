#!/bin/bash
set -xv
cd $HOME/w/nabla/infra/docker-compose/pgwatch
docker compose -f ./docker/docker-compose.yml up
exit 0
