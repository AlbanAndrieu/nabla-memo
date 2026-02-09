#!/bin/bash
set -xv

export NOMAD_ADDR_UAT="http://nomad.uat.int.jusmundi.com:4646"
#Consul UI: http://nomad.uat.int.jusmundi.com:8500

export NOMAD_ADDR=$NOMAD_ADDR_UAT
export NOMAD_TOKEN=$NOMAD_TOKEN_UAT

nomad ui -authenticate
#nomad ui -token

exit 0
