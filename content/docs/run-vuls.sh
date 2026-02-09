#!/bin/bash
set -xv

sudo apt-get install debian-goodies reboot-notifier

# https://vuls.io/docs/en/install-with-vulsctl.html
# https://til.dave.engineer/security-vulnerabilities/vuls-package-vulnerability-scanner/

wget https://raw.githubusercontent.com/vulsio/vulsctl/master/install-host/install.sh
sudo bash install.sh

cd /home/albanandrieu/w/jm/github
git clone https://github.com/vulsio/vulsctl.git

cp vulsctl/install-host/update-all{,-custom-ubuntu}.sh
nano vulsctl/install-host/update-all-custom-ubuntu.sh
# Comment out the lines for operating systems you don't need

cd vulsctl/install-host
time sudo bash update-all-custom-ubuntu.sh

# Aletrnative way

sudo apt-get install vuls
sudo mkdir /opt/vuls

ln -s /workspace/users/albandrieu30/jm/github/vulsctl/config.toml config.toml
sudo geany /opt/vuls/config.toml
# from https://vuls.io/docs/en/config.toml.html
vuls configtest

goval-dictionary fetch-redhat 7 8
goval-dictionary fetch-ubuntu 14 16 18 20

gost fetch redhat --after 2016-01-01
gost fetch ubuntu --after 2016-01-01

vuls scan
vuls report
sudo vuls tui

exit 0
