#!/bin/bash
#set -xv

# See https://arstechnica.com/gadgets/2020/03/ubuntu-20-04s-zsys-adds-zfs-snapshots-to-package-management/

sudo apt-get install python2-minimal
sudo apt-get install python-apt

#sudo apt remove gnome-shell-extension-ubuntu-dock
sudo apt-get install gnome-shell-extension-multi-monitors
sudo apt-get install gnome-shell-extension-weather
sudo apt-get install gnome-shell-extension-autohidetopbar gnome-shell-extension-dash-to-panel gnome-shell-extension-hard-disk-led chrome-gnome-shell
sudo apt-get install gnome-calendar

sudo ufw disable
sudo swapoff -a

sudo add-apt-repository -y ppa:teejee2008/ppa
sudo apt update
sudo apt install timeshift

sudo do-release-upgrade -d -f DistUpgradeViewGtk3

# See https://stackoverflow.com/questions/67298443/when-gcc-11-will-appear-in-ubuntu-repositories

sudo apt purge openhpid

# Fix service Show Plymouth Boot Screen
# See https://serverfault.com/questions/845471/service-start-request-repeated-too-quickly-refusing-to-start-limit
systemctl show -p CanReload plymouth
# Add StartLimitBurst
sudo nano /lib/systemd/system/plymouth-start.service
StartLimitBurst=0
sudo systemctl status plymouth-start.service

# couldn't connect to zsys daemon
sudo systemctl restart zsysd.service

# Since Ubuntu 20 network changed to netplan

exit 0
