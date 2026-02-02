#!/bin/bash
set -xv

# inside redis jail

# https://github.com/bsdpot/minipot

pkg install minipot
# included
# pkg install signify traefik

minipot-init
# nomad_user:  -> root
# nomad_env:  -> PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/sbin:/bin
# nomad_args:  -> -config=/usr/local/etc/nomad/minipot-server.hcl
# consul_enable: YES -> YES
# nomad_enable: YES -> YES
# traefik_enable:  -> YES
# traefik_conf:  -> /usr/local/etc/minipot-traefik.toml

cat /usr/local/etc/pot/pot.conf

edit /usr/local/etc/nomad/minipot-server.hcl
# add
data_dir = "/var/tmp/nomad"

# pkg install nomad

# No cluster leader
rm -Rf /var/tmp/nomad
sysrc nomad_enable=YES
service nomad start

nomad agent -server -data-dir=/var/tmp/nomad

/usr/local/bin/nomad server members

/usr/local/bin/nomad ui

echo "http://172.17.0.55:4646/ui/jobs?namespace=*"

# install consul agent
pkg install consul consul-alerts
sysrc consul_enable=YES
pkg install consul_exporter
sysrc consul_exporter_enable=YES

edit /usr/local/etc/consul.d/minipot-agent.json
# datacenter minipot

# consul: 1.20.4_1 -> 1.21.1_1
service consul start
The 'ui' field is deprecated. Use the 'ui_config.enabled' field instead
 "ui_config": {
   "enabled": true
 },
 "datacenter": "mini-dc",
# "datacenter": "minipot",

ls -lrta /var/db/consul
rm -Rf /var/db/consul/*

consul info

echo "http://172.17.0.55:8500/ui/mini-dc/services"

sysctl kern.racct.enable
minipot-start

tail -f /var/log/nomad/nomad.log
cat /var/log/consul/consul.log
cat /var/log/traefik.log

echo "http://172.17.0.55:9002/dashboard/#"

echo "http://172.17.0.55:8080/"

cd /usr/local/share/examples/minipot
nomad run nginx.job

curl -H 'host: hello-web.minipot' 127.0.0.1:8080

# on albandrieu
sudo geany /etc/consul.d/consul.hcl
# datacenter = "mini-dc"
datacenter = "minipot"
retry_join = ["172.17.0.55"]
advertise_addr = "172.17.0.57"

/usr/bin/consul agent -config-dir=/etc/consul.d/

sudo geany /etc/nomad.d/nomad.hcl
datacenter = "minipot"

# nomad server force-leave albandrieu
# sudo rm -Rf  /opt/consul/*
# sudo chown -R consul:consul /opt/consul

nomad node status
# Remove old bad register nomad node
nomad system gc

sudo geany /etc/nomad.d/nomad.hcl
sudo cp /etc/nomad.d/nomad.hcl /etc/nomad.d/nomad.hcl-2024-12-06
# comment
# bootstrap_expect = 1

------------
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

# Full configuration options can be found at https://developer.hashicorp.com/nomad/docs/configuration

data_dir  = "/opt/nomad/data"
bind_addr = "0.0.0.0"
# bind_addr = "172.17.0.57"
datacenter = "minipot"

server {
  # license_path is required for Nomad Enterprise as of Nomad v1.1.1+
  #license_path = "/etc/nomad.d/license.hclic"
  enabled          = true
 #  bootstrap_expect = 1
}

client {
  enabled = true
  # servers = ["127.0.0.1"]
  # servers = ["172.17.0.55"]
}

advertise {
    http = "172.17.0.57:4646"
    rpc = "172.17.0.57:4647"
    serf = "172.17.0.57:4648"
}

consul {
    # The address to the Consul agent.
    address = "127.0.0.1:8500"
    ssl = false
    ca_file = ""
    grpc_ca_file = ""
    cert_file = ""
    key_file = ""
    token = ""
    # The service name to register the server and client with Consul.
    # server_service_name = "nomad-servers"
    # client_service_name = "nomad-clients"
    tags = []

    # Enables automatically registering the services.
    auto_advertise = true

    # Enabling the server and client to bootstrap using Consul.
    server_auto_join = true
    client_auto_join = true
}

ui {
    enabled =  true
	  label {
	  	text             = "NABLA Cluster"
	  	background_color = "#047ge8"
	  	text_color       = "#FFFFFF"
	  }
}

vault {
    enabled = true
    address = "http://172.17.0.44:8200" # https://vault.albandrieu.com
    allow_unauthenticated = true
    # create_from_role = "nomad-cluster"
    task_token_ttl = ""
    ca_file = ""
    ca_path = ""
    cert_file = ""
    key_file = ""
    tls_server_name = ""
    tls_skip_verify = true
    namespace = ""
}

telemetry {
  collection_interval = "1s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}

--------

pkg install redis_exporter
sysrc redis_exporter_enable=YES
service redis_exporter start
# :9121/metrics
# For redis://172.17.0.55:6379

-----
cat /etc/rc.conf
nomad_env="PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/sbin:/bin"
nomad_args="-config=/usr/local/etc/nomad/minipot-server.hcl"
traefik_enable="YES"
traefik_conf="/usr/local/etc/minipot-traefik.toml"

-----

edit /usr/local/etc/minipot-traefik.toml

----------
[entryPoints]
  [entryPoints.http]
    address = "0.0.0.0:8080"
  [entryPoints.traefik]
    address = "0.0.0.0:9002"
  [entryPoints.metrics]
    address = "0.0.0.0:8082"

[log]
  filePath = "/var/log/traefik.log"
  format = "common"
  level="INFO"

[accessLog]
  filePath = "/var/log/traefik-access.log"
  format = "common"

[api]
  insecure = true
  dashboard = true

[providers]
  [providers.file]
    filename = "dynamic.toml"
  [providers.consulCatalog]
    exposedByDefault = true
    defaultRule = "Host(`{{ .Name }}.minipot`)"
    stale = false
    [providers.consulCatalog.endpoint]
    address = "http://127.0.0.1:8500"

[metrics]
  [metrics.prometheus]
    entryPoint = "metrics"
    # addEntryPointsLabels = true
    addRoutersLabels = true

[certificatesResolvers.myresolver.acme]
  email = "alban.andrieu@free.fr"
  # storage = "/letsencrypt/acme.json"
  storage = "local/acme.json"
  # tlsChallenge = "true" # <== Enable TLS-ALPN-01 to generate and renew ACME certs
  dnschallenge = "true"
  [certificatesResolvers.myresolver.acme.dnsChallenge]
    provider = "cloudflare"
    resolvers = ["1.1.1.1:53", "8.8.8.8:53"]
-------

ls -lrta /var/log/traefik.log
service traefik restart

exit 0
