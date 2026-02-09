#!/bin/bash
set -xv

sudo apt install python3-openstackclient
pip3 install python-openstackclient python-novaclient python-swiftclient

source ./workspace/users/albandrieu30/nabla/env/home/os-dev.sh
openstack flavor list
openstack server list

# See https://horizon.cloud.ovh.net/project/containers/

openstack volume type list

# See https://horizon.cloud.ovh.net/project/api_access/

openstack endpoint list

geany $HOME/.config/openstack/clouds.yaml

ls -lrta $HOME/cloud.conf

#export OS_CLOUD=openstack
#openstack --os-cloud openstack flavor list
openstack project list

# See https://andreaskaris.github.io/blog/openstack/using_clouds_yaml/

# See https://horizon.cloud.ovh.net/
# The easiest way to get the file is opening horizon and going to Project -> Project -> API Access. Then, click on "Download OpenStack RC File" and select to download the "clouds.yaml" file.

openstack --os-cloud openstack token issue
# Get the project id with:
openstack project list | grep $OS_PROJECT_NAME | awk '{print $2}'

# https://horizon.cloud.ovh.net/project/networks/ports/852b4b45-1566-4ed6-bb6b-18d93e2c500d/detail
openstack port set --enable-port-security 852b4b45-1566-4ed6-bb6b-18d93e2c500d
openstack port set --security-group common 852b4b45-1566-4ed6-bb6b-18d93e2c500d

# ext net port for 217.182.143.150
# https://horizon.cloud.ovh.net/project/networks/ports/eb102b85-2c9d-4d6b-8889-1c55d4fc9ee0/detail
openstack port set --enable-port-security eb102b85-2c9d-4d6b-8889-1c55d4fc9ee0
openstack port set --security-group test-alban eb102b85-2c9d-4d6b-8889-1c55d4fc9ee0

# Add 82.66.4.247/0

# backup image
export OS_REGION_NAME=GRA1
# 88194286-489d-44a3-bd5b-587a4390aa93
openstack server image create --name GPUinstance f1898ffe-f2a2-4ed2-9c8d-7a3fc93cd5d8
openstack image list --private
openstack image save --file GPUinstance.qcow f1898ffe-f2a2-4ed2-9c8d-7a3fc93cd5d8

# OVH API
echo "https://ca.api.ovh.com/"

exit 0
