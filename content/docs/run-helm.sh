#!/bin/bash
set -xv
sudo snap remove helm
sudo snap install helm --classic
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm version --short --client
sudo nano /etc/apparmor.d/tunables/home.d/albandri
@{HOMEDIRS}+=/data1/home/
sudo systemctl restart apparmor.service
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add custom --username aandrieu --password XXX https://registry-tmp.albandrieu.com/chartrepo/fusion-risk
helm repo add harbor http://albandrieu:6532/chartrepo/library
helm search repo harbor
helm fetch nabla/test --version 1.2.0-20200307T050112.shae5a6f0c.166
kubectl config view --raw
helm init --service-account=tiller --history-max 200
helm repo list
helm plugin install https://github.com/helm/helm-2to3
helm plugin list
helm 2to3
helm create testChart
helm lint testChart
helm package testChart
mkdir testChartDir
mv testChart-0.1.0.tgz testChartDir/
helm repo index testChartDir/ --url http://albandrieu:6532/chartrepo/library
helm repo update
helm install --name my-release harbor/testchart
helm list
helm install harbor/testChart --generate-name --debug --version 0.1.0
sudo apt-get install bash-completion
echo 'source <(kubectl completion bash)' >> ~/.bashrc
helm search repo stable
helm repo add jenkinsci https://charts.jenkins.io
helm repo update
helm search repo jenkinsci
exit 0
