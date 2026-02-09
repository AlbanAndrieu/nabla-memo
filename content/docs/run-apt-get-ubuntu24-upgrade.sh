#!/bin/bash
set -xv

# geany /etc/update-manager/release-upgrades
# lts

# python2 linked to python3
mv /usr/bin/python /usr/bin/python-TODELETE
do-release-upgrade

# resume
sudo screen -D -r

sudo apt remove zsys
sudo apt remove synergy

# files changed
nano /etc/minidlna.conf
nano /etc/pam.d/login
nano /etc/sysctl.conf
# Append fs.inotify.max_user_watches=524288
ll /etc/fwupd/fwupd.conf

sudo apt purge unity gdm3 xfce4
sudo apt install ubuntu-deskop
# Install Ubuntu on Xorg

# do-release-upgrade -d
# resume screen after losting ssh
sudo screen -D -r

exit 0
