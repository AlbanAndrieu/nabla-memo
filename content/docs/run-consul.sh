#!/bin/bash
set -xv

# See https://www.consul.io/downloads

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install consul

consul agent -dev
consul members
curl localhost:8500/v1/catalog/nodes

# http://localhost:8500/ui/dc1/services

sudo systemctl status consul.service
sudo systemctl restart consul.service

less /var/log/syslog

# See https://learn.hashicorp.com/tutorials/consul/access-control-setup
consul acl bootstrap

AccessorID:       YYYY
SecretID:         XXXXX
Description:      Bootstrap Token (Global Management)
Local:            false
Create Time:      2022-05-03 13:32:45.429101852 +0000 UTC
Policies:
   00000000-0000-0000-0000-000000000001 - global-management

consul members -token "XXXXX"

export CONSUL_HTTP_TOKEN="XXXXX"

# https://learn.hashicorp.com/tutorials/consul/add-remove-servers
consul info

#consul validate /etc/consul/
#consul validate consul-acl.hcl

consul acl policy create -name vault-service -rules @vault.hcl

# https://www.consul.io/commands/acl
consul acl policy create -name "acl-replication" -description "Token capable of replicating ACL policies" -rules 'acl = "read"'
consul acl token create -description "Agent Policy Replication - my-agent" -policy-name "acl-replication"

# See https://learn.hashicorp.com/tutorials/vault/sop-backup

# https://medium.com/ww-engineering/consul-snapshot-vault-kubernetes-503dc3332b76

ssh gra1vaultsrvuat1
consul snapshot save backup.snap
consul snapshot inspect backup.snap

# Or https://github.com/leocomelli/vault-backup
# Or https://github.com/shaneramey/vault-backup

consul members
# check the leader
consul operator raft list-peers
# transfer-leader
consul operator raft transfer-leader -id="server id"

#gra1vaultsrvuat1 must be client not server
ll /opt/consul
# clean and recreate
rm -Rf /opt/consul/*
mkdir /opt/consul
chown -R consul:consul  /opt/consul

consul leave
#in /etc/consul/config.json change server to false and bootstrap to 0

#/usr/local/bin/consul agent -config-file=/etc/consul/config.json -config-dir=/etc/consul.d -pid-file=/run/consul/consul.pid
ll /opt/consul/services/21a4a62122091adceee3ed46f2203984fddb47c0e8449e84d4a600b8a961baac
rm -Rf /opt/consul/services/21a4a62122091adceee3ed46f2203984fddb47c0e8449e84d4a600b8a961baac
rm -Rf /opt/consul/checks/e47e6bd95bd97ad58d99ca0ff1e0d8bdf5832dcc38ca15e2da3ab00c3cd07367

# generate secret
consul keygen

# See https://github.com/ansible-community/ansible-consul/pull/496

nano /etc/consul/config.json
#    "telemetry": {
#        "prometheus_retention_time": "48h",
#        "disable_hostname": true
#    }

sudo geany /etc/consul.d/consul.hcl
datacenter = "mini-dc"
retry_join = ["172.17.0.55"]
advertise_addr = "172.17.0.57"

/usr/bin/consul agent -config-dir=/etc/consul.d/
# Please configure one with 'bind' and/or 'advertise'

curl http://127.0.0.1:8500/v1/agent/metrics\?format\=prometheus
#NOK curl http://nomad.uat.int.jusmundi.com:8500/v1/agent/metrics\?format\=prometheus
# http://gra1vaultsrvuat1.int.jusmundi.com:8500/ui/gra/services
curl -X GET 'http://10.30.0.66:8500/v1/agent/metrics?format=prometheus' -H 'Authorization: XXXX'

# See https://learn.hashicorp.com/tutorials/consul/kubernetes-api-gateway


# Register external services

# https://github.com/nairnavin/practical-nomad-consul

# See https://developer.hashicorp.com/consul/api-docs/catalog#deregister-entity

curl --request PUT --data @external-services/postgres.json 172.16.1.101:8500/v1/catalog/register
#curl --request PUT --data @external-services/postgres.json nomad.dev.int.jusmundi.com:8500/v1/catalog/register
curl --request PUT --data @external-services/fromage.json nomad.dev.int.jusmundi.com:8500/v1/catalog/register
curl --request PUT --data @external-services/postgres-deregister.json nomad.dev.int.jusmundi.com:8500/v1/catalog/deregister

consul catalog services
# #get list of all services and urls, per consul
# consul catalog services -tags
# wget -qO- 'http://127.0.0.1:8500/v1/catalog/services' |jq .

#consul services deregister -id postgres
consul catalog nodes
consul catalog nodes -detailed

consul operator raft  list-peers
consul operator autopilot get-config
consul operator autopilot state

ssh gradbsev2integr01
ssh gra9jusaiexpgpu1
wget https://releases.hashicorp.com/consul-esm/0.9.1/consul-esm_0.9.1_linux_amd64.zip
unzip consul-esm_0.9.1_linux_amd64.zip

sudo cp ./consul-esm /usr/bin/
sudo mkdir /etc/consul-esm.d
sudo nano /etc/consul-esm.d/config.hcl

consul-esm -config-file=/etc/consul-esm.d/config.hcl -config-dir /etc/consul-esm.d

consul config read -kind service-defaults -name web
consul config list -kind service-defaults

# consul services
# consul reload
consul watch -type=service -service=es-search-engine

consul monitor

dig @127.0.0.1 -p 8600 -t srv status.service.gra.dev.consul

exit 0
