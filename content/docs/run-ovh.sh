#!/bin/bash
set -xv
sudo apt install python3-swiftclient
source /workspace/users/albandrieu30/nabla/env/home/pass/os-dev-pdf.sh
export OS_REGION_NAME="GRA"
swift list
swift stat assistant-storage-dev
swift list assistant-storage-dev
swift upload transfert/pdf document-pdf-2022-12-09.tgz -S 1073741824
source /workspace/users/albandrieu30/nabla/env/home/pass/os-dev.sh
export OS_REGION_NAME="GRA"
openstack container list
openstack volume type list
openstack volume list
pipx install awscli
pipx install awscli-plugin-endpoint --include-deps
unset S3_AWS_ACCESS_KEY_ID
unset S3_AWS_SECRET_ACCESS_KEY
unset AWS_DEFAULT_REGION
unset AWS_REGION
aws s3 --profile s3-dev ls --endpoint-url https://s3.gra.perf.cloud.ovh.net
aws --endpoint-url https://s3.gra.perf.cloud.ovh.net --profile s3-dev s3 rm s3://nomad-minio-dev --recursive --force
sudo apt-get install --reinstall libwebp-dev
pip install ovh
exit 0
