#!/bin/bash
set -xv

# https://docs.dagger.io/cli/465058/install/
cd /usr/local
curl -L https://dl.dagger.io/dagger/install.sh | sudo sh

mkdir -p /bash-completion/completions
sudo chmod 777 /bash-completion/completions
dagger completion bash >/bash-completion/completions/dagger

pip install dagger-io

# NO Java https://betterprogramming.pub/a-java-sdk-proof-of-concept-for-dagger-io-b1067e256116

exit 0
