#!/bin/bash
set -xv
sudo apt install python3-openstackclient
pip3 install python-openstackclient python-novaclient python-swiftclient
source ./workspace/users/albandrieu30/nabla/env/home/os-dev.sh
openstack flavor list
openstack server list
openstack volume type list
openstack endpoint list
geany $HOME/.config/openstack/clouds.yaml
ls -lrta $HOME/cloud.conf
openstack project list
openstack --os-cloud openstack token issue
openstack project list|  grep $OS_PROJECT_NAME|  awk '{print $2}'
openstack port set --enable-port-security 852b4b45-1566-4ed6-bb6b-18d93e2c500d
openstack port set --security-group common 852b4b45-1566-4ed6-bb6b-18d93e2c500d
openstack port set --enable-port-security eb102b85-2c9d-4d6b-8889-1c55d4fc9ee0
openstack port set --security-group test-alban eb102b85-2c9d-4d6b-8889-1c55d4fc9ee0
export OS_REGION_NAME=GRA1
openstack server image create --name GPUinstance f1898ffe-f2a2-4ed2-9c8d-7a3fc93cd5d8
openstack image list --private
openstack image save --file GPUinstance.qcow f1898ffe-f2a2-4ed2-9c8d-7a3fc93cd5d8
echo "https://ca.api.ovh.com/"
exit 0
