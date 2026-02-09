#!/bin/bash
set -xv

sudo apt-get install -y gnome-keyring libsecret-tools # dbusx11

#secret-tool store --label="My Label" myattribute foobar
#secret-tool lookup myattribute foobar
#secret-tool clear myattribute foobar

secret-tool store --label="BW_PASSWORD" "BW_ACCESS_JM" "PASSWORD"
unset BW_ACCESS_JM_PASSWORD
secret-tool lookup "BW_ACCESS_JM" "PASSWORD"

export BW_ACCESS_JM_PASSWORD="$(secret-tool lookup "BW_ACCESS_JM" "PASSWORD")"

exit 0
