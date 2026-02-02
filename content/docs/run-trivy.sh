#!/bin/bash
set -xv

#https://microscanner.aquasec.com/signup

#https://my.aquasec.com

#https://www.aquasec.com/wiki

docker login registry.aquasec.com -u <AQUA_USERNAME> -p <AQUA_PASSWORD>
docker pull registry.aquasec.com/scanner:4.2

#https://hub.docker.com/u/aquasec/
#https://jenkins.io/doc/pipeline/steps/aqua-security-scanner/

docker pull registry.albandrieu.com/global-bakery/aquasec-scanner-cli:latest
docker run --rm --volume ${pwd()}:/mnt --volume /var/run/docker.sock:/var/run/docker.sock registry.albandrieu.com/global-bakery/aquasec-scanner-cli:latest scan --user scanner --password password --host http://fr1cslbmts0304:8080 --local --direct-cc --jsonfile /mnt/test.AquaSec --htmlfile /mnt/test registry.albandrieu.com/fusion-risk/ansible-jenkins-slave-test:latest

# See https://aquasecurity.github.io/trivy/v0.20.2/getting-started/installation/

#curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin v0.30.4
#wget https://github.com/aquasecurity/trivy/releases/download/v0.20.2/trivy_0.20.2_Linux-64bit.deb
#sudo dpkg -i trivy_0.20.2_Linux-64bit.deb
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy

export TRIVY_VERSION=${TRIVY_VERSION:-"0.52.1"}


curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v${TRIVY_VERSION}

trivy --version

#docker pull aquasec/trivy:0.28.1
docker pull ghcr.io/aquasecurity/trivy:0.52.1

helm repo add aquasecurity https://aquasecurity.github.io/helm-charts/
helm repo update
helm search repo trivy
helm install my-trivy aquasecurity/trivy

code --install-extension trivy-vscode-extension # aqua docker

trivy image docker.io/selenium/standalone-chrome:3.141.59-20201117
# Filesystem report
trivy filesystem --scanners misconfig,vuln --exit-code 0 --skip-dirs=.direnv --skip-dirs=.venv --skip-dirs=megalinter-reports/ --ignore-unfixed  --dependency-tree .
#--format template --template "@contrib/gitlab-codequality.tpl" -o gl-codeclimate-fs.json .

trivy filesystem --scanners misconfig,vuln --exit-code 0 --skip-dirs=.direnv --skip-dirs=.venv --skip-dirs=megalinter-reports/ --ignore-unfixed --ignorefile .trivyignore.yaml --format=json . > trivy.json

curl -sSL -o /tmp/html.tpl https://github.com/aquasecurity/trivy/raw/v${TRIVY_VERSION}/contrib/html.tpl
# curl -sSL -o /tmp/gitlab-codequality.tpl https://github.com/aquasecurity/trivy/raw/v${TRIVY_VERSION}/contrib/gitlab-codequality.tpl

trivy image --exit-code 0 --no-progress --scanners vuln,misconfig,secret,license  --ignore-unfixed --format template --template "@/tmp/html.tpl" -o scan.html "783876277037.dkr.ecr.eu-west-3.amazonaws.com/nuxt:latest"


# DD import
sudo docker run --rm maibornwolff/dd-import:latest dd-reimport-findings.sh trivy.json

exit 0
