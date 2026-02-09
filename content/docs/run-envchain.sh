#!/bin/bash
set -xv

# See https://github.com/sorah/envchain

brew install envchain

envchain --set prod AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY

echo $AWS_ACCESS_KEY_ID
echo $AWS_SECRET_ACCESS_KEY

envchain prod env | grep AWS_

aws ecr get-login
aws ecr get-login-password --region ${AWS_REGION:-"eu-west-3"} | docker login --username AWS --password-stdin ${OCI_REGISTRY:-"783876277037.dkr.ecr.eu-west-3.amazonaws.com"}
docker push 783876277037.dkr.ecr.eu-west-3.amazonaws.com/prodigy-annotator:uat-serve-feature-prepare-data-a26c6bbd

envchain --list

exit 0
