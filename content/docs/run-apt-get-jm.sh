#!/bin/bash
sudo apt install python3-swiftclient
sudo apt-get update
sudo apt-get install make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
sudo apt-get install libnss3-dev libasound2
curl -sL https://deb.nodesource.com/setup_16.x|  bash -&&apt-get update&&apt-get install --no-install-recommends -y nodejs=16*
npm install -g npm@8.5.0 webdriver-manager@12.1.7 yarn@1.22.18
sudo apt-get install debtree
debtree --with-suggests libsqlite3-0 > out.dot
dot -T png -o out.png out.dot
exit 0
