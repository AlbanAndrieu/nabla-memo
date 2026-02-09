#!/bin/bash
set -xv

# https://github.com/cybertec-postgresql/pgwatch

cd $HOME/w/nabla/infra/docker-compose/pgwatch

docker compose -f ./docker/docker-compose.yml up

# http://pgwatch-admin.service.gra.uat.consul/

exit 0
