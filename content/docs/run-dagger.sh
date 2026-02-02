#!/bin/bash
set -xv
cd /usr/local
curl -L https://dl.dagger.io/dagger/install.sh|  sudo sh
mkdir -p /bash-completion/completions
sudo chmod 777 /bash-completion/completions
dagger completion bash > /bash-completion/completions/dagger
pip install dagger-io
exit 0
