#!/bin/bash
set -xv

#See https://argoproj.github.io/argo-cd/
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

exit 0
