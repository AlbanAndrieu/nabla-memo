#!/bin/bash
set -xv
sudo apt-get install -y gnome-keyring libsecret-tools
secret-tool store --label="BW_PASSWORD" "BW_ACCESS_JM" "PASSWORD"
unset BW_ACCESS_JM_PASSWORD
secret-tool lookup "BW_ACCESS_JM" "PASSWORD"
export BW_ACCESS_JM_PASSWORD="$(secret-tool lookup "BW_ACCESS_JM" "PASSWORD")"
exit 0
