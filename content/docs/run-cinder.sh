#!/bin/bash
set -xv

# See https://github.com/kubernetes/cloud-provider-openstack/blob/master/docs/cinder-csi-plugin/using-cinder-csi-plugin.md
# See https://github.com/kubernetes/cloud-provider-openstack/blob/master/docs/openstack-cloud-controller-manager/using-openstack-cloud-controller-manager.md#global
# https://github.com/kubernetes/cloud-provider-openstack/blob/master/docs/cinder-csi-plugin/using-cinder-csi-plugin.md

# Config id copied into /var/nomad/alloc/6513382d-ece8-ed92-907c-576d623ce9b5/controller/local/cloud.conf

# https://github.com/hashicorp/nomad/issues/12963
# openstack volume list
# openstack volume type list
# openstack volume set --type high-speed-gen2 --retype-policy on-demand VOLUME_NAME_OR_ID
# high-speed-gen2
# openstack volume show cinder-gra-influxdb-dev
# openstack volume show cinder-gra-influxdb-dev -c 'availability_zone'
# nomad plugin status
# nomad plugin status -verbose cinder-csi_plugin
# nomad volume status --namespace=*
# nomad volume status --namespace=* cinder-gra-influxdb-dev
# ll /var/nomad/alloc/3b05f849-ae16-d5f0-af8b-144867022ff3/alloc/logs
# https://github.com/kubernetes/cloud-provider-openstack/issues/325
# curl http://169.254.169.254/openstack/latest/meta_data.json
# cat /var/lib/cloud/data/instance-id
# https://github.com/hashicorp/nomad/issues/13028

source /workspace/users/albandrieu30/nabla/env/home/pass/os-prod.sh
ll ~/cloud.conf
# or openrc.sh

openstack project list

cinder --os-project-domain-name ${OS_PROJECT_DOMAIN_NAME} --os-project-id ${OS_PROJECT_ID} list
cinder show 926d92ea-37e9-4e03-9b7c-d131c82c41d0


exit 0
