#!/bin/bash
set -xv
brew uninstall draft helm
wget https://azuredraft.blob.core.windows.net/draft/draft-v0.16.0-linux-amd64.tar.gz
tar -xvf draft-v0.16.0-linux-amd64.tar.gz
sudo mv linux-amd64/draft /usr/local/bin/draft
draft version
draft init
draft pack-repo remove github.com/Azure/draft
draft config list
draft up
draft pack-repo update
draft pack list
exit 0
