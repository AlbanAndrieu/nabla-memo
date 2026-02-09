#!/bin/bash
set -xv

# See https://github.com/antonbabenko/pre-commit-terraform
DIR=${HOME}/.git-template
git config --global init.templateDir ${DIR}
pre-commit init-templatedir -t pre-commit ${DIR}

sudo apt install -y unzip software-properties-common python3 python3-pip

python3 -m pip install --upgrade pip
pip3 install --no-cache-dir pre-commit
pip3 install --no-cache-dir checkov
curl -L "$(curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest | grep -o -E -m 1 "https://.+?-linux-amd64.tar.gz")" >terraform-docs.tgz && tar -xzf terraform-docs.tgz terraform-docs && rm terraform-docs.tgz && chmod +x terraform-docs && sudo mv terraform-docs /usr/bin/
curl -L "$(curl -s https://api.github.com/repos/accurics/terrascan/releases/latest | grep -o -E -m 1 "https://.+?_Linux_x86_64.tar.gz")" >terrascan.tar.gz && tar -xzf terrascan.tar.gz terrascan && rm terrascan.tar.gz && sudo mv terrascan /usr/bin/ && terrascan init
# curl -L "$(curl -s https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E -m 1 "https://.+?_linux_amd64.zip")" >tflint.zip && unzip tflint.zip && rm tflint.zip && sudo mv tflint /usr/bin/
sudo snap install tflint
curl -L "$(curl -s https://api.github.com/repos/aquasecurity/tfsec/releases/latest | grep -o -E -m 1 "https://.+?tfsec-linux-amd64")" >tfsec && chmod +x tfsec && sudo mv tfsec /usr/bin/
sudo apt install -y jq &&
  curl -L "$(curl -s https://api.github.com/repos/infracost/infracost/releases/latest | grep -o -E -m 1 "https://.+?-linux-amd64.tar.gz")" >infracost.tgz && tar -xzf infracost.tgz && rm infracost.tgz && sudo mv infracost-linux-amd64 /usr/bin/infracost && infracost register
curl -L "$(curl -s https://api.github.com/repos/minamijoyo/tfupdate/releases/latest | grep -o -E -m 1 "https://.+?_linux_amd64.tar.gz")" >tfupdate.tar.gz && tar -xzf tfupdate.tar.gz tfupdate && rm tfupdate.tar.gz && sudo mv tfupdate /usr/bin/

#See http://pre-commit.com/#advanced

# Uninstall local pre-commit, instead install it on virtualenv
sudo pip uninstall pre-commit
sudo pip3.8 uninstall pre-commit
#sudo pip install pre-commit
#sudo pip install pre-commit-hooks
sudo /opt/ansible/env38/bin/pip3.8 install pre-commit==4.0.1

/opt/ansible/env38/bin/pre-commit --version

pre-commit install -f --hook-type commit-msg
pre-commit autoupdate
pre-commit migrate-config

pre-commit run --all-files

pre-commit clean

# error old pre-commit
# key: minimum_pre_commit_version
# =====> pre-commit version 4.0.1 is required but version 2.20.0 is installed.  Perhaps run `pip install --upgrade pre-commit`.
# geany .git/hooks/pre-commit
# change
# INSTALL_PYTHON = '/opt/ansible/env38/bin/python'
# by
# INSTALL_PYTHON = 'python3'

exit 0
