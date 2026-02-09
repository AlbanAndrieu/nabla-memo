#!/bin/bash
set -xv

# https://github.com/awslabs/amazon-ecr-credential-helper
sudo apt install amazon-ecr-credential-helper
which docker-credential-ecr-login
ll /usr/bin/docker-credential-ecr-login

geany ~/.docker/config.json

# Replace
# 	"credHelpers": {
# 		"783876277037.dkr.ecr.eu-west-3.amazonaws.com": "ecr-login"
# 	}
# by
# 	"credsStore": "pass"

# AND login
aws ecr get-login-password --profile ecr | docker login --username AWS --password-stdin "783876277037.dkr.ecr.eu-west-3.amazonaws.com"
# aws ecr get-login-password --region eu-west-3 | docker login --username AWS --password-stdin "783876277037.dkr.ecr.eu-west-3.amazonaws.com"
docker login registry.gitlab.com

exit 0
