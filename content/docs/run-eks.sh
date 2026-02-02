#!/bin/bash
set -xv
nslookup k8s-traefik-traefiki-b7be92e81c-d74cbe68ab2215ee.elb.us-east-1.amazonaws.com
argocd app create conflict-checker \
  --repo https://gitlab.com/jusmundi-group/infrastructure/argocd-applications.git \
  --path applications/conflict-checker/default/manifests \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace jussquad \
  --sync-policy automated \
  --auto-prune \
  --self-heal
kubectl exec
exit 0
