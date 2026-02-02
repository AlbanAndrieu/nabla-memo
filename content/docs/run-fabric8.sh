#!/bin/bash
set -xv
sudo apt install libvirt-bin qemu-kvm
sudo usermod -a -G libvirtd albandri
newgrp libvirtd
curl -sS https://get.fabric8.io/download.txt|  bash
echo 'export PATH=$PATH:~/.fabric8/bin' >> ~/.bashrc
source ~/.bashrc
gofabric8 start --package=system --namespace fabric8
export GITHUB_OAUTH_CLIENT_ID=c52c293400ba80af105a
export GITHUB_OAUTH_CLIENT_SECRET=microsoft
exit 0
