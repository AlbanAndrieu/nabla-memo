#!/bin/bash
set -xv

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install waypoint

waypoint --version
#CLI: v0.10.1 (830e74dd0)

nomad job stop --namespace=* -purge waypoint-static-runner
nomad job stop --namespace=* -purge waypoint-server
sudo rm -Rf /mnt/data/nomad/waypoint/*
sudo rm -Rf /mnt/data/nomad/waypoint-runner/*
# two times run
waypoint install -platform=nomad -accept-tos -nomad-host-volume=waypoint -nomad-runner-host-volume=waypoint -nomad-dc=gra -nomad-consul-datacenter=gra -nomad-consul-service-hostname=waypoint-ui.service.gra.dev.consul -nomad-host=http://nomad.dev.int.jusmundi.com:4646 -nomad-namespace=infrastructure -vvv

-nomad-service-provider=nomad
waypoint server bootstrap -server-addr=10.30.0.91:9701 -server-tls-skip-verify

waypoint context list
# It will create
~/.config/waypoint/context/bootstrap-1664544587.hcl

# bootstrap-1664544587

#install-1664958523

#waypoint context create \
#    -server-addr=10.30.0.91:9701 \
#    -server-auth-token=abcd1234 \
#    -server-tls \
#    -server-tls-skip-verify \
#    -set-default my-server

# From the UI
waypoint context create \
  -server-addr=waypoint-ui.service.gra.dev.consul:9701 \
  -server-auth-token=XXX \
  -server-require-auth=true \
  -set-default waypoint-ui.service.gra.dev.consul-ui

geany ~/.config/waypoint/context/waypoint-ui.service.gra.dev.consul-ui.hcl
# change tls_skip_verify

waypoint context verify

#waypoint server config-set -advertise-addr=10.30.0.91:9701
##waypoint server config-set -advertise-addr=waypoint-ui.service.gra.dev.consul:9701

# See https://waypoint-ui.service.gra.dev.consul:9702/

# https://github.com/hashicorp/waypoint/issues/3588 -nomad-runner-host-volume

ll ~/.config/waypoint/context/install-1664534764.hcl
ll /home/albandrieu/.config/waypoint/

#waypoint server config-set
#waypoint ui -authenticate

#Advertise Address: 10.30.0.91:9701
#Web UI Address: https://10.30.0.91:9701
waypoint user token

#waypoint install -platform=docker -accept-tos
waypoint init
waypoint build
waypoint up
waypoint deploy

waypoint status -app=rest-api-tenants -project=rest-api-tenants

waypoint ui -authenticate
# See https://localhost:9702/

waypoint runner profile list

waypoint runner agent -label=org=jusmundi -label=env=dev

waypoint runner forget nomad-01GE7E02X9XMZDE7KT7C4Q9NG3

waypoint runner install -platform=docker -docker-runner-network=waypoint -server-addr=10.30.0.91:9701 -server-tls-skip-verify=true
#01GE7D06EV6NFACWCCAATXQZCP
waypoint runner install -platform=nomad -server-addr=10.30.0.91:9701 -nomad-host-volume=waypoint-runner -server-tls-skip-verify -nomad-dc=gra -server-require-auth
#01GE7KS516V39KFM1DJ6NHD7TX

#waypoint runner profile set -name=docker-jusmundi-dev -plugin-type=docker -target-runner-label=org=jusmundi -target-runner-label=env=dev

#waypoint config set -runner -scope=global AWS_ACCESS_KEY_ID=abcd AWS_SECRET_ACCESS_KEY=1234

waypoint config set -runner -scope=global NOMAD_SECRETS_DIR=secrets

waypoint config set -runner -workspace-scope=dev NOMAD_TOKEN=$NOMAD_TOKEN_DEV
waypoint config set -runner -workspace-scope=dev ENV=dev
waypoint config set -runner -workspace-scope=uat NOMAD_TOKEN=$NOMAD_TOKEN_UAT
waypoint config set -runner -workspace-scope=uat ENV=uat
waypoint config set -runner -workspace-scope=prod NOMAD_TOKEN=$NOMAD_TOKEN_PROD

waypoint config get -runner

waypoint runner profile list
waypoint runner list

waypoint pipeline list
waypoint artifact list-builds
waypoint destroy -auto-approve

# See https://github.com/hashicorp/waypoint/issues/3596
# https://mpolinowski.github.io/docs/DevOps/Hashicorp/2022-06-08-hashicorp-waypoint-nomad/2022-06-09/

exit 0
