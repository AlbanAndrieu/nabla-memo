#!/bin/bash
set -xv

asdf plugin add kubectl
asdf install kubectl latest
asdf set --home kubectl latest

kubectl version --client

# See https://github.com/lensapp/lens/releases/tag/v4.1.3

sudo snap install kontena-lens --classic

#See https://github.com/roboll/helmfile/releases

wget https://github.com/roboll/helmfile/releases/download/v0.138.2/helmfile_linux_amd64
sudo cp helmfile_linux_amd64 /usr/local/bin/helmfile
sudo chmod +x /usr/local/bin/helmfile

# See https://helm.sh/docs/community/related/#helm-plugins
# See https://github.com/search?q=topic%3Ahelm-plugin&type=Repositories

helm plugin install https://github.com/databus23/helm-diff --verify=false
#helm plugin install https://github.com/futuresimple/helm-secrets
helm plugin install https://github.com/karuppiah7890/helm-schema-gen --verify=false
helm plugin install https://github.com/ContainerSolutions/helm-monitor --verify=false
helm plugin install https://github.com/ContainerSolutions/helm-convert --verify=false
helm plugin install https://github.com/lrills/helm-unittest --verify=false
helm plugin install https://github.com/aslafy-z/helm-git --verify=false
# helm plugin remove helm-git

#See https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/

# curl -s "https://raw.githubusercontent.com/\
# kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
# sudo cp kustomize /usr/local/bin/kustomize
# sudo chmod +x /usr/local/bin/kustomize

mise use kustomize

# See https://github.com/norwoodj/helm-docs#installation
#NOK GO111MODULE=on go get github.com/norwoodj/helm-docs/cmd/helm-docs
wget https://github.com/norwoodj/helm-docs/releases/download/v1.5.0/helm-docs_1.5.0_linux_amd64.deb

# See https://github.com/ksync/ksync
# As root
curl https://ksync.github.io/gimme-that/gimme.sh | bash

# See https://www.kubeval.com/
wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz
tar xf kubeval-linux-amd64.tar.gz
sudo cp kubeval /usr/local/bin

# See https://krew.sigs.k8s.io/docs/user-guide/setup/install/
# https://blog.stephane-robert.info/docs/conteneurs/orchestrateurs/outils/kubectl-plugins/
# (
#   set -x
#   cd "$(mktemp -d)" &&
#     curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
#     tar zxvf krew.tar.gz &&
#     KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_$(uname -m | sed -e 's/x86_64/amd64/' -e 's/arm.*$/arm/' -e 's/aarch64$/arm64/')" &&
#     "$KREW" install krew
# )

# https://krew.sigs.k8s.io/plugins/

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

ll  ~/.krew/bin

microk8s.kubectl krew update
kubectl krew upgrade
krew version

krew search

krew install flame
#sudo apt install openjdk-8-dbg
sudo apt install openjdk-11-dbg
gdb /usr/lib/jvm/java-1.11.0-openjdk-amd64/lib/server/libjvm.so -ex 'info address UseG1GC'
gdb /usr/lib/jvm/java-14-oracle/lib/server/libjvm.so -ex 'info address UseG1GC'
kubectl flame "my-helm-sample-cb64797d8-kwv9p" -t 1m --lang java -f /tmp/flamegraph.svg --namespace fr-standalone-aandrieu --kubeconfig ~/.kube/config
kubectl krew install graph
#kubectl graph pods --field-selector status.phase=Running -n kube-system | dot -T svg -o pods.svg
kubectl graph pods --field-selector status.phase=Running -n fr-standalone-aandrieu --kubeconfig=$HOME/.kube/config | dot -T svg -o pods.svg

kubectl krew install ctx
kubectl krew install ns
kubectl krew install sniff
# bash <( curl -sfL https://raw.githubusercontent.com/boz/kail/master/godownloader.sh) -b "$GOPATH/bin"
kubectl sniff jenkins-master-7f5c756465-76scc -n jenkins -p --pod-creation-timeout 15m

kubectl krew install tree
kubectl tree deployment my-develop-helm-sample -n fr-standalone-aandrieu --kubeconfig=$HOME/.kube/config

kubectl krew install score
helm template packs/helm-sample/charts/ | kubectl score -

krew install popeye
krew install who-can stern neat ai cert-manager cost flyte karmada kc kubescape kyverno retina starboard

kubectl-ai --mcp-client

krew list

kubectl plugin list

# External repo

helm --debug repo add bitnami https://charts.bitnami.com/bitnami --force-update
helm --debug repo add jenkins https://charts.jenkins.io --force-update

POPEYE_REPORT_DIR=$(pwd) popeye --kubeconfig ~/.kube/config --namespace fr-standalone-aandrieu --cluster treasury-trba --save --out html --output-file report.html

# Ingress
#run : kubectl create -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-0.32.0/deploy/static/provider/cloud/deploy.yaml
#or with helm :
# See https://kubernetes.github.io/ingress-nginx/deploy/
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install my-nginx ingress-nginx/ingress-nginx

# See https://github.com/derailed/k9s
# curl -sS https://webinstall.dev/k9s | bash
# using mise instead

# AWK EKS
mise use kubectl awscli helm

aws eks --region us-east-1 update-kubeconfig --name jusmundi-eks-cluster

aws eks create-access-entry \
    --cluster-name jusmundi-eks-cluster \
    --principal-arn arn:aws:iam::783876277037:user/aandrieu
    # arn:aws:iam::783876277037:user/gitlab.cicd

kubectl events pods conflict-checker-neo4j-0

k get pods -A

# https://blog.stephane-robert.info/docs/conteneurs/orchestrateurs/outils/kube-score/
asdf plugin add kube-score
asdf install kube-score latest
asdf set --home kube-score latest

kube-score version
kube-score score mon-deploiement.yaml
kube-score score mon_repertoire_de_configurations/

# https://kubernetes.io/docs/reference/kubectl/generated/kubectl_debug/
kubectl debug conflict-checker-69dbdb6c74-rfdnq -it --image=busybox -n jussquad

exit 0
