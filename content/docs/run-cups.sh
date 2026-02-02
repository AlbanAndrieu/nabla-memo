#!/bin/bash
set -xv
sudo apt-get install cups
sudo apt-get install cups-bsd
sudo apt-get install cups-filters
sudo /usr/sbin/lpinfo --make-and-model "SX105" -m
./run-printer-epson.sh
system-config-printer
sudo nano /etc/cups/cupsd.conf
sudo systemctl restart cups.service
lpq
lprm -a
lpstat -s
sudo systemctl stop cups
sudo systemctl disable cups
sudo apt purge cups* --autoremove
sudo rm -rf /etc/cups /var/log/cups /var/cache/cups
snap list
sudo snap remove cups
sudo snap set system experimental.parallel-instances=true
sudo snap refresh --hold cups
sudo nano /etc/apt/preferences.d/no-snap.pref
Add the following lines:
Package: snapd
Pin: release a=*
Pin-Priority: -1
Save and exit, then refresh the APT package manager:
sudo apt update
exit 0
