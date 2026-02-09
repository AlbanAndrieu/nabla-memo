#!/bin/bash
set -xv

# https://storiesfromtheherd.com/traefik-in-nomad-using-consul-and-tls-5be0007794ee

curl http://traefik.service.gra.dev.consul:8081/api/rawdata | jq

# forward auth example https://github.com/hashicorp/nomad/issues/15763

exit 0
