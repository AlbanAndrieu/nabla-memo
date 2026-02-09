#!/bin/bash
set -xv

# Le traefik dans EKS a LoadBalancer
# Il va créer un LB http://k8s-traefik-traefiki-b7be92e81c-d74cbe68ab2215ee.elb.us-east-1.amazonaws.com/
# Avec un patte pour chaque region
nslookup k8s-traefik-traefiki-b7be92e81c-d74cbe68ab2215ee.elb.us-east-1.amazonaws.com
# Dans la UI AWS le lead balancer est dans EC2
# https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#LoadBalancer:loadBalancerArn=arn:aws:elasticloadbalancing:us-east-1:783876277037:loadbalancer/net/k8s-traefik-traefiki-b7be92e81c/d74cbe68ab2215ee;tab=listeners
# C'est un LB pour Traefik

# Traefik lui fait LB pour les services

argocd app create conflict-checker \
  --repo https://gitlab.com/jusmundi-group/infrastructure/argocd-applications.git \
  --path applications/conflict-checker/default/manifests \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace jussquad \
  --sync-policy automated \
  --auto-prune \
  --self-heal

kubectl exec

# Create AmazonEKSPodIdentityAWSNetworkFlowMonitorAgentRole role
# Then Container network observability in the UI
# AWS Network Flow Monitor Agent

exit 0
