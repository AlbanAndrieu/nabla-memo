#!/bin/bash
sudo apt-get install python2-minimal
sudo apt-get install python-apt
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
sudo apt purge openhpid
systemctl show -p CanReload plymouth
sudo nano /lib/systemd/system/plymouth-start.service
StartLimitBurst=0
sudo systemctl status plymouth-start.service
sudo systemctl restart zsysd.service
exit 0
