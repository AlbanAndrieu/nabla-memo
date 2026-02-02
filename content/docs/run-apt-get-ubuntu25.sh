#!/bin/bash
set -xv
do-release-upgrade
sudo apt remove mysql-server*
sudo rm -Rf /etc/apt/sources.list.d/symfony-stable.list
cd /etc/apt/sources.list.d/
sudo rm microsoft-ubuntu-noble-prod.list.migrate ntop.list.migrate symfony-stable.list.migrate nodesource.list.migrate atomic.list.migrate lens.list.migrate
sudo rm /usr/share/bash-completion/completions/docker
sudo apt install bash-completion
mkdir -p ~/.local/share/bash-completion/completions
docker completion bash > ~/.local/share/bash-completion/completions/docker
wget -qO-  https://keybase.io/docs/server_security/code_signing_key.asc|  sudo tee /etc/apt/trusted.gpg.d/keybase.asc
sudo apt modernize-sources
./run-dns.sh
./run-dns-test.sh
exit 0
