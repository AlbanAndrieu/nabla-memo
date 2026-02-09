#!/bin/bash
#set -xv

#Flux multi-cluster / management-cluster
#See https://github.com/makkes/flux-mc-control-plane

k get ks -A
flux tree ks workspace -n workspace-dev

# See https://artifacthub.io/packages/search?org=cert-manager

exit 0
