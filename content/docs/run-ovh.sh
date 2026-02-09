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
# openstack flavor list
export OS_REGION_NAME="GRA"
openstack container list
openstack volume type list
openstack volume list

# https://docs.ovh.com/fr/public-cloud/debuter-avec-volumes-api-openstack/

#openstack endpoint create --region RegionOne \
# volumev3 public http://controller:8776/v3/%\(project_id\)s

# See https://docs.ovh.com/fr/storage/object-storage/s3/identity-and-access-management/
pipx install awscli
pipx install awscli-plugin-endpoint --include-deps
# pip3 install awscli awscli-plugin-endpoint

unset S3_AWS_ACCESS_KEY_ID
unset S3_AWS_SECRET_ACCESS_KEY
unset AWS_DEFAULT_REGION
unset AWS_REGION

aws s3 --profile s3-dev ls --endpoint-url https://s3.gra.perf.cloud.ovh.net
# https://docs.ovh.com/fr/storage/object-storage/s3/getting-started-with-object-storage/
aws --endpoint-url https://s3.gra.perf.cloud.ovh.net --profile s3-dev s3 rm s3://nomad-minio-dev --recursive --force

# https://www.ovh.com/manager/#/hub
# https://status.us.ovhcloud.com/

# https://help.ovhcloud.com/csm/en-public-cloud-databases-postgresql-migrate-on-prem-to-pcd?id=kb_article_view&sysparm_article=KB0049464
# https://help.ovhcloud.com/csm/en-web-cloud-db-getting-started-postgresql?id=kb_article_view&sysparm_article=KB0056728#import-your-database-via-the-command-line
# https://help.ovhcloud.com/csm/en-public-cloud-databases-postgresql-concept-high-availability?id=kb_article_view&sysparm_article=KB0049421
# https://help.ovhcloud.com/csm?id=csm_cases_requests

sudo apt-get install --reinstall libwebp-dev
# https://github.com/ovh/python-ovh
pip install ovh

exit 0
