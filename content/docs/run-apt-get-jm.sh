#!/bin/bash
#set -xv

#openpvn
##python2.7
#python3.7 3.8
#ansible 2.12
#terraform 1.0.11 and 1.1.6
#buildah
#podman
#hasicorp nomade consule

#swift
sudo apt install python3-swiftclient

sudo apt-get update
sudo apt-get install make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# For https://gitlab.com/jusmundi-group/web/front

sudo apt-get install libnss3-dev libasound2

curl -sL https://deb.nodesource.com/setup_16.x | bash - &&
  apt-get update && apt-get install --no-install-recommends -y nodejs=16*

npm install -g npm@8.5.0 webdriver-manager@12.1.7 yarn@1.22.18
# yo@latest phantomas@1.20.1 dockerfile_lint@0.3.4 newman@5.2.2 newman-reporter-htmlextra@1.19.7 xunit-viewer@5.1.11

# See https://askubuntu.com/questions/261772/how-to-visually-display-dependencies-of-a-package
sudo apt-get install debtree
debtree --with-suggests libsqlite3-0 >out.dot
dot -T png -o out.png out.dot

exit 0
