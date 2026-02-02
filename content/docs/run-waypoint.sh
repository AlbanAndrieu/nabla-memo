#!/bin/bash
set -xv
curl -fsSL https://apt.releases.hashicorp.com/gpg|  sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update&&  sudo apt-get install waypoint
waypoint --version
nomad job stop --namespace=* -purge waypoint-static-runner
nomad job stop --namespace=* -purge waypoint-server
sudo rm -Rf /mnt/data/nomad/waypoint/*
sudo rm -Rf /mnt/data/nomad/waypoint-runner/*
waypoint install -platform=nomad -accept-tos -nomad-host-volume=waypoint -nomad-runner-host-volume=waypoint -nomad-dc=gra -nomad-consul-datacenter=gra -nomad-consul-service-hostname=waypoint-ui.service.gra.dev.consul -nomad-host=http://nomad.dev.int.jusmundi.com:4646 -nomad-namespace=infrastructure -vvv
-nomad-service-provider=nomad
waypoint server bootstrap -server-addr=10.30.0.91:9701 -server-tls-skip-verify
waypoint context list
~/.config/waypoint/context/bootstrap-1664544587.hcl
waypoint context create \
  -server-addr=waypoint-ui.service.gra.dev.consul:9701 \
  -server-auth-token=XXX \
  -server-require-auth=true \
  -set-default waypoint-ui.service.gra.dev.consul-ui
geany ~/.config/waypoint/context/waypoint-ui.service.gra.dev.consul-ui.hcl
waypoint context verify
ll ~/.config/waypoint/context/install-1664534764.hcl
ll /home/albandrieu/.config/waypoint/
waypoint user token
waypoint init
waypoint build
waypoint up
waypoint deploy
waypoint status -app=rest-api-tenants -project=rest-api-tenants
waypoint ui -authenticate
waypoint runner profile list
waypoint runner agent -label=org=jusmundi -label=env=dev
waypoint runner forget nomad-XXX
waypoint runner install -platform=docker -docker-runner-network=waypoint -server-addr=10.30.0.91:9701 -server-tls-skip-verify=true
waypoint runner install -platform=nomad -server-addr=10.30.0.91:9701 -nomad-host-volume=waypoint-runner -server-tls-skip-verify -nomad-dc=gra -server-require-auth
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
exit 0
