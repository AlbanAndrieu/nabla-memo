#!/bin/bash
#set -xv

nomad agent -dev

consul agent -dev
consul members
curl localhost:8500/v1/catalog/nodes

vault server -dev

exit 0
