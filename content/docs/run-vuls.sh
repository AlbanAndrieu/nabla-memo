#!/bin/bash
set -xv
sudo apt-get install debian-goodies reboot-notifier
wget https://raw.githubusercontent.com/vulsio/vulsctl/master/install-host/install.sh
sudo bash install.sh
cd /home/albanandrieu/w/jm/github
git clone https://github.com/vulsio/vulsctl.git
cp vulsctl/install-host/update-all{,-custom-ubuntu}.sh
nano vulsctl/install-host/update-all-custom-ubuntu.sh
cd vulsctl/install-host
time sudo bash update-all-custom-ubuntu.sh
sudo apt-get install vuls
sudo mkdir /opt/vuls
ln -s /workspace/users/albandrieu30/jm/github/vulsctl/config.toml config.toml
sudo geany /opt/vuls/config.toml
vuls configtest
goval-dictionary fetch-redhat 7 8
goval-dictionary fetch-ubuntu 14 16 18 20
gost fetch redhat --after 2016-01-01
gost fetch ubuntu --after 2016-01-01
vuls scan
vuls report
sudo vuls tui
exit 0
