#!/bin/bash
#set -xv
shopt -s extglob

#set -ueo pipefail
set -eo pipefail

WORKING_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt-get install cockpit

# See https://localhost:9090/

cockpit-bridge --packages
sudo apt-cache search cockpit
sudo apt-get install cockpit-system cockpit-storaged cockpit-networkmanager cockpit-machines
sudo apt-get install cockpit-doc cockpit-machines sssd-dbus
sudo apt-get install cockpit-docker
#sudo apt-get install realmd

sudo apt install -y appstream-util
sudo apt-get install cockpit-kubernetes

sudo apt purge pcp cockpit-pcp

nano /lib/systemd/system/cockpit.socket
#[Socket]
#ListenStream=9898

# See https://localhost:9898/

sudo systemctl daemon-reload
sudo systemctl restart cockpit.socket

exit 0
