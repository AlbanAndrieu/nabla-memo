#!/bin/bash
set -xv

# https://support.lastpass.com/s/document-item?language=en_US&bundleId=lastpass&topicId=LastPass/t_cid_and_hash_locate.html&_LANG=enus
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
