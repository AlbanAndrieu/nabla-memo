#!/bin/bash
set -xv
echo "https://github.com/lastpass/lastpass-cli"
sudo apt-get --no-install-recommends -yqq install \
  bash-completion \
  build-essential \
  cmake \
  libcurl4 \
  libcurl4-openssl-dev \
  libssl-dev \
  libxml2 \
  libxml2-dev \
  pkg-config \
  ca-certificates \
  xclip
sudo apt install lastpass-cli
lpass
exit 0
