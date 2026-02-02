#!/bin/bash
set -xv
source /workspace/users/albandrieu30/nabla/env/home/pass/os-prod.sh
ll ~/cloud.conf
openstack project list
cinder --os-project-domain-name $OS_PROJECT_DOMAIN_NAME   --os-project-id $OS_PROJECT_ID   list
cinder show 926d92ea-37e9-4e03-9b7c-d131c82c41d0
exit 0
