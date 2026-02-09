#!/bin/bash
set -xv

echo "Install duf"

wget https://github.com/muesli/duf/releases/download/v0.7.0/duf_0.7.0_linux_amd64.deb
sudo dpkg -i duf_0.7.0_linux_amd64.deb

#duf -all
duf --sort size

exit 0
