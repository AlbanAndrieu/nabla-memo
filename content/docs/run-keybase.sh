#!/bin/bash
set -xv

# https://github.com/keybase/client
# https://keybase.io/docs/the_app/install_linux

curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install ./keybase_amd64.deb
run_keybase

# https://book.keybase.io/docs/cli#basics

keybase version

# user albandrieu
# Go on https://gist.github.com/ and create keybase.md
# https://gist.github.com/AlbanAndrieu/4b337edf664c67aac60eba5ebabec2ed
keybase pgp select
# B12DECD437E9E1C8 for user id : Alban Andrieu <alban.andrieu@free.fr>

# https://keybase.io/albandrieu
# https://keybase.io/albandrieu/pgp_keys.asc
# curl https://keybase.io//albandrieu/pgp_keys.asc | gpg --import

keybase prove dns albandrieu.com

sudo apt update --audit
# sudo gpg --keyserver keys.gnupg.net --recv-key 222B85B0F90BE2D24CFEB93F47484E50656D16C7
wget -qO-  https://keybase.io/docs/server_security/code_signing_key.asc | sudo tee /etc/apt/trusted.gpg.d/keybase.asc

exit 0
