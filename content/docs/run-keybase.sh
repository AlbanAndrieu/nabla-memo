#!/bin/bash
set -xv
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install ./keybase_amd64.deb
run_keybase
keybase version
keybase pgp select
keybase prove dns albandrieu.com
sudo apt update --audit
wget -qO-  https://keybase.io/docs/server_security/code_signing_key.asc|  sudo tee /etc/apt/trusted.gpg.d/keybase.asc
exit 0
