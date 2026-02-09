#!/bin/bash
set -xv

#sudo apt-get install task-print-server
sudo apt-get install cups
sudo apt-get install cups-bsd     # cmd tools
sudo apt-get install cups-filters # printer without pilote

# Check the printer driver exists
sudo /usr/sbin/lpinfo --make-and-model "SX105" -m
#gutenprint.5.3://escp2-sx105/expert Epson Stylus SX105 - CUPS+Gutenprint v5.3.3
#everywhere IPP Everywhere

# See https://openprinting.org/printers

./run-printer-epson.sh

system-config-printer

sudo nano /etc/cups/cupsd.conf
sudo systemctl restart cups.service

# See http://localhost:631/

#See http://localhost:631/admin
# albandrieu

lpq

#lprm 12321

# remove tasks
lprm -a

# All available printer
lpstat -s

# Remove https://askubuntu.com/questions/1486694/how-to-completely-disable-remove-cups-on-ubuntu-snaps

sudo systemctl stop cups
sudo systemctl disable cups
sudo apt purge cups* --autoremove
sudo rm -rf /etc/cups /var/log/cups /var/cache/cups

snap list
sudo snap remove cups

# Disable snap auto-install for CUPS:
sudo snap set system experimental.parallel-instances=true
sudo snap refresh --hold cups

# Blacklist CUPS from being installed by snaps: Edit the snapd preferences file:

sudo nano /etc/apt/preferences.d/no-snap.pref
Add the following lines:

Package: snapd
Pin: release a=*
Pin-Priority: -1
Save and exit, then refresh the APT package manager:

sudo apt update

exit 0
