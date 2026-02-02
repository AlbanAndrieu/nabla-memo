#!/bin/bash
set -xv
DIR=$HOME/.git-template
git config --global init.templateDir $DIR
pre-commit init-templatedir -t pre-commit $DIR
sudo apt install -y unzip software-properties-common python3 python3-pip
python3 -m pip install --upgrade pip
pip3 install --no-cache-dir pre-commit
pip3 install --no-cache-dir checkov
curl -L "$(curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest|  grep -o -E -m 1 "https://.+?-linux-amd64.tar.gz")" > terraform-docs.tgz&& tar -xzf terraform-docs.tgz terraform-docs&&  rm terraform-docs.tgz&&  chmod +x terraform-docs&&  sudo mv terraform-docs /usr/bin/
curl -L "$(curl -s https://api.github.com/repos/accurics/terrascan/releases/latest|  grep -o -E -m 1 "https://.+?_Linux_x86_64.tar.gz")" > terrascan.tar.gz&& tar -xzf terrascan.tar.gz terrascan&&  rm terrascan.tar.gz&&  sudo mv terrascan /usr/bin/&&  terrascan init
sudo snap install tflint
curl -L "$(curl -s https://api.github.com/repos/aquasecurity/tfsec/releases/latest|  grep -o -E -m 1 "https://.+?tfsec-linux-amd64")" > tfsec&& chmod +x tfsec&&  sudo mv tfsec /usr/bin/
sudo apt install -y jq&&curl -L "$(curl -s https://api.github.com/repos/infracost/infracost/releases/latest|grep -o -E -m 1 "https://.+?-linux-amd64.tar.gz")" > infracost.tgz&&tar -xzf infracost.tgz&&rm infracost.tgz&&sudo mv infracost-linux-amd64 /usr/bin/infracost&&infracost register
curl -L "$(curl -s https://api.github.com/repos/minamijoyo/tfupdate/releases/latest|  grep -o -E -m 1 "https://.+?_linux_amd64.tar.gz")" > tfupdate.tar.gz&& tar -xzf tfupdate.tar.gz tfupdate&&  rm tfupdate.tar.gz&&  sudo mv tfupdate /usr/bin/
sudo pip uninstall pre-commit
sudo pip3.8 uninstall pre-commit
sudo /opt/ansible/env38/bin/pip3.8 install pre-commit==4.0.1
/opt/ansible/env38/bin/pre-commit --version
pre-commit install -f --hook-type commit-msg
pre-commit autoupdate
pre-commit migrate-config
pre-commit run --all-files
pre-commit clean
exit 0
