#!/bin/bash
set -xv
sudo apt install amazon-ecr-credential-helper
which docker-credential-ecr-login
ll /usr/bin/docker-credential-ecr-login
geany ~/.docker/config.json
aws ecr get-login-password --profile ecr|  docker login --username AWS --password-stdin "783876277037.dkr.ecr.eu-west-3.amazonaws.com"
docker login registry.gitlab.com
exit 0
