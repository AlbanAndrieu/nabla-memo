#!/bin/bash
set -xv
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta6/aio/deploy/recommended.yaml
kubectl config view
kubectl proxy --address 0.0.0.0 --port=8582 --accept-hosts '.*'
curl http://localhost:8582/api/
token=$(microk8s.kubectl -n kube-system get secret|  grep default-token|  cut -d " " -f1)
microk8s.kubectl -n kube-system describe secret $token
microk8s.enable dns dashboard ingress
microk8s.kubectl get all --all-namespaces
service/kubernetes-dashboard ClusterIP 10.152.183.244
token=$(microk8s.kubectl -n kube-system get secret|  grep default-token|  cut -d " " -f1)
microk8s.kubectl -n kube-system describe secret $token
microk8s.kubectl proxy --accept-hosts=.* --address=0.0.0.0&
microk8s.kubectl -n kube-system edit deploy kubernetes-dashboard -o yaml
sudo snap install kontena-lens --classic
exit 0
