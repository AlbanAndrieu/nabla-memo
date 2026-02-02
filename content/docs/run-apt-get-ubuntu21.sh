#!/bin/bash
sudo apt-get --with-new-pkgs upgrade
sudo apt-get remove xscreensaver-gl
sudo apt-get purge synergy webmin
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
ll /etc/apt/sources.list.d/*dead*
geany /etc/apt/sources.list.d/deadsnakes-ubuntu-ppa-hirsute.list
sudo mv /usr/local/bin/ansible-lint /usr/local/bin/ansible-lint-TODELETE
sudo mv /usr/local/bin/ansible-lint-junit /usr/local/bin/ansible-lint-junit-TODELETE
sudo mv /usr/local/bin/pre-commit /usr/local/bin/pre-commit-TODELETE
sudo apt-get install openjdk-17-jdk
./run-gnome.sh
exit 0
