#!/bin/bash
set -xv
echo "Install bat"
sudo apt-get remove bat
wget https://github.com/sharkdp/bat/releases/download/v0.19.0/bat_0.19.0_amd64.deb
sudo dpkg -i bat_0.19.0_amd64.deb
sudo mv /bin/bat /bin/batcat
alias cat='batcat --paging=never'
exit 0
