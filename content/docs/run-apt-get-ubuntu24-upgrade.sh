#!/bin/bash
set -xv
mv /usr/bin/python /usr/bin/python-TODELETE
do-release-upgrade
sudo screen -D -r
sudo apt remove zsys
sudo apt remove synergy
nano /etc/minidlna.conf
nano /etc/pam.d/login
nano /etc/sysctl.conf
ll /etc/fwupd/fwupd.conf
sudo apt purge unity gdm3 xfce4
sudo apt install ubuntu-deskop
sudo screen -D -r
exit 0
