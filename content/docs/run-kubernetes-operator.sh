#!/bin/bash
set -xv

# https://github.com/operator-framework/operator-lifecycle-manager/blob/master/doc/install/install.md#install-a-release

kubectl create -f https://github.com/operator-framework/operator-lifecycle-manager/releases/latest/download/crds.yaml
kubectl create -f https://github.com/operator-framework/operator-lifecycle-manager/releases/latest/download/olm.yaml

# https://www.keycloak.org/operator/installation

kubectl apply -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/26.5.0/kubernetes/keycloaks.k8s.keycloak.org-v1.yml
kubectl apply -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/26.5.0/kubernetes/keycloakrealmimports.k8s.keycloak.org-v1.yml

kubectl create namespace keycloak
kubectl -n keycloak apply -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/26.5.0/kubernetes/kubernetes.yml

exit 0
