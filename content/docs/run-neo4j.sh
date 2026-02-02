#!/bin/bash
set -xv

# https://neo4j.com/download-thanks-desktop/?edition=desktop&flavour=unix&release=1.5.9&offline=true&utm_medium=PaidSearch&utm_source=google&utm_campaign=GDB&utm_content=AMS-X-Conversion-GDB-Text&utm_term=download%20neo4j&gclid=Cj0KCQiAmNeqBhD4ARIsADsYfTcc9gQ5XAqa0HcuZluNpMvwz7ux_QmxT5tNt7HNacxcuSz766kBdpMaAgtYEALw_wcB

chmod +x neo4j-desktop-1.5.9-x86_64.AppImage

echo ${NEO4J_DESKTOP_ACTIVATION_KEY}

// change 7688 to 7687 when routing will work
neo4j://neo4j-api.service.gra.uat.consul:7687
neo4j://localhost:7474

export NEO4J_USERNAME="neo4j"
# export NEO4J_PASSWORD=""

helm repo add neo4j https://helm.neo4j.com/neo4j
helm repo update

kubectl get statefulsets -n jussquad
kubectl exec conflict-checker-neo4j-0  -n jussquad -- tail -n50 /logs/neo4j.log

# See https://neo4j.com/docs/operations-manual/current/kubernetes/accessing-neo4j/#_applications_accessing_neo4j_from_outside_kubernetes
kubectl run -it --rm --image neo4j:2025.10.1 cypher-shell -- cypher-shell -a bolt://conflict-checker-neo4j.jussquad.svc.cluster.local

# neo4j://conflict-checker-neo4j.jussquad.svc.cluster.local:7687

# LB k8s-jussquad-conflict-c3a34428cc-f21abcdd2c19a5a2.elb.us-east-1.amazonaws.com

kubectl run --rm -it --image "neo4j:2025.10.1" cypher-shell \
     -- cypher-shell -a "neo4j://conflict-checker-neo4j.jussquad.svc.cluster.local:7687" -u neo4j -p "${NEO4J_PASSWORD}"

kubectl create secret generic conflict-checker-secrets \
  -n jussquad \
  --from-literal=NEO4J_PASSWORD='${NEO4J_PASSWORD}'

kubectl get secret conflict-checker-neo4j-auth -oyaml -n jussquad | yq -r '.data.NEO4J_AUTH' | base64 -d

neo4j://conflict-checker-neo4j.jussquad.svc.cluster.local:7687

# https://devseatit.com/guides/neo4j-end-to-end-guide/

kubectl exec  -it -n jussquad conflict-checker-neo4j-0  -- bash
kubectl exec -n jussquad conflict-checker-neo4j-0 -- nc -zv localhost 7687

kubectl exec -it hnr-test-app-5d4875db9d-s7xqf -- bash

# https://neo4j.com/docs/operations-manual/current/kubernetes/accessing-neo4j-ingress/

helm show values neo4j/neo4j-reverse-proxy

helm install rp neo4j/neo4j-reverse-proxy -f /path/to/your/ingress-values.yaml
# debug with offlineMaintenanceModeEnabled
helm upgrade conflict-checker-neo4j neo4j/neo4j -f values/neo4j/values.yaml -n jussquad

kubectl exec "conflict-checker-neo4j-0" -it -- bash
nohup neo4j-admin check-consistency --database=neo4j &> job.out < /dev/null &
tail -f job.out

exit 0
