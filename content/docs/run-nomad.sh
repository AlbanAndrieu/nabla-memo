#!/bin/bash
set -xv

# See https://www.nomadproject.io/

# See https://www.nomadproject.io/downloads

# Ubuntu 22.10
rm /etc/apt/sources.list.d/archive_uri-https_apt_releases_hashicorp_com-kinetic.list
rm /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-kinetic.list

./run-terraform.sh

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install nomad

# See https://developer.hashicorp.com/nomad/tutorials/enterprise/production-deployment-guide-vm-with-consul
sudo systemctl status nomad.service
sudo systemctl restart nomad.service

sudo journalctl -n 50 -fu nomad.service

nomad operator raft list-peers

# Since 1.4.2 change raft_protocol = 2 to 3
# See https://github.com/hashicorp/nomad/issues/6344

# See https://www.nomadproject.io/docs/upgrade
# See https://www.nomadproject.io/docs/upgrade#upgrading-a-single-server-cluster-to-raft-version-3

# for gra1nomadconsulsrvdev1
/etc/nomad.d/server.hcl: raft_protocol = 2

nomad agent -dev

# https://danielabaron.me/blog/nomad-tips-and-tricks/
nomad -autocomplete-install

# http://localhost:4646/ui/jobs

nomad status

nomad job stop db-backup-myapp
nomad job stop -purge db-backup-myapp
nomad system gc
nomad system reconcile summaries

# GPU
# https://developer.hashicorp.com/nomad/plugins/devices/nvidia
docker run --rm --gpus all nvidia/cuda:12.8.1-base-ubuntu22.04 nvidia-smi

plugin "nomad-device-nvidia" {
  config {
    enabled            = true
    ignored_gpu_ids    = ["GPU-fef8089b", "GPU-ac81e44d"]
    fingerprint_period = "1m"
  }
}

nomad node status -verbose 1d6

sudo usermod -G docker -a nomad

echo $NOMAD_ADDR
nomad acl policy list
nomad acl policy info admin

nomad acl policy info cicd

# nomad acl policy delete data
nomad acl token self

nomad acl token list
nomad acl token create -name="Nomad CICD Token" -global -policy="cicd"
# UAT - Nomad CICD Token
nomad job run -verbose -token=XXX -var env=uat -var team=uat rendered.nomad

nomad monitor -log-level TRACE

# See https://learn.hashicorp.com/tutorials/nomad/vault-nomad-secrets

curl \
    --request PUT \
    https://localhost:4646/v1/system/gc
nomad server members

# See https://github.com/mr-karan/nomctx

nomctx --list-namespaces
nomctx --list-clusters
nomctx --set-cluster=uat

# https://github.com/jippi/awesome-nomad

# https://github.com/hashicorp/nomad-driver-podman
# https://github.com/hashicorp/nomad-pack-community-registry/tree/main/packs
# https://github.com/ataccama/nomad-deploy

nomad operator autopilot get-config

# security with https://github.com/open-policy-agent/conftest

LATEST_VERSION=$(wget -O - "https://api.github.com/repos/open-policy-agent/conftest/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c 2-)
wget "https://github.com/open-policy-agent/conftest/releases/download/v${LATEST_VERSION}/conftest_${LATEST_VERSION}_Linux_x86_64.tar.gz"
tar xzf conftest_${LATEST_VERSION}_Linux_x86_64.tar.gz
sudo mv conftest /usr/local/bin

conftest test main.tf

# go get github.com/fatih/hclfmt
go install github.com/fatih/hclfmt@latest

nomad operator scheduler set-config -memory-oversubscription true

# wget https://github.com/hashicorp/nomad-pack/releases/download/nightly/nomad-pack_0.0.1.techpreview.4-1_amd64.deb
nomad-pack registry list
# nomad-pack registry add example gitlab.com/mikenomitch/pack-registry
# nomad-pack registry add example gitlab.com/mikenomitch/pack-registry
nomad-pack registry add community https://github.com/hashicorp/nomad-pack-community-registry/
nomad-pack plan loki --var app_count=1 --registry=community
nomad-pack plan loki --var datacenters=gra --registry=community

# As root
pipx install nomad-tools

nomad job status --namespace=* | sort | grep running >nomad-running-${GOBAL_VAR_env}-2024-04-24.log

# Restart on alloc
nomad job allocs --namespace=* legal-research-assistant
nomad alloc status --namespace=* 6ead5857

sudo snap remove levant
curl -L https://github.com/hashicorp/levant/releases/download/0.2.9/linux-amd64-levant -o levant

nomad node status
nomad system gc

exit 0
