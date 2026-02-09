#!/bin/bash
#set -xv

# https://askubuntu.com/questions/1183098/dock-disappeared-after-upgrade-to-ubuntu-19-10-only-visible-in-activities-overv

# Fix the following packages have been kept back

sudo apt-get --with-new-pkgs upgrade

# hypertorus very slow
sudo apt-get remove xscreensaver-gl

# Remove old package
sudo apt-get purge synergy webmin
# FYI : webmin replaced by cockpit
# Remove failing serive
sudo apt-get purge fwupd ureadahead redshift mon sendmail*

sudo canonical-livepatch status --verbose
sudo systemctl disable canonical-livepatch.service
systemd-analyze blame
sudo systemctl disable click-system-hooks.service

sudo apt update
apt list --upgradable
apt upgrade
apt-get upgrade ubuntu-advantage-tools update-notifier-common
apt-get upgrade libgl1-mesa-dri libgtk-3-0 linux-generic linux-headers-generic linux-image-generic linux-tools-generic sosreport
apt autoremove

sudo apt full-upgrade
sudo do-release-upgrade

#sudo add-apt-repository ppa:deadsnakes/ppa
#sudo apt update
#sudo apt-get install python3-distutils

#See https://brennan.io/2021/06/21/deadsnakes-hirsute/
ll /etc/apt/sources.list.d/*dead*
geany /etc/apt/sources.list.d/deadsnakes-ubuntu-ppa-hirsute.list
# https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa

sudo mv /usr/local/bin/ansible-lint /usr/local/bin/ansible-lint-TODELETE
sudo mv /usr/local/bin/ansible-lint-junit /usr/local/bin/ansible-lint-junit-TODELETE
sudo mv /usr/local/bin/pre-commit /usr/local/bin/pre-commit-TODELETE
#sudo rm /usr/local/bin/node-TODELETE /usr/local/bin/pip3.8-TODELETE /usr/local/bin/virtualenv-TODELETE

sudo apt-get install openjdk-17-jdk

# Disable wayland
./run-gnome.sh

exit 0
