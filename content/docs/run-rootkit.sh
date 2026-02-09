#!/bin/bash
set -xv

#http://doc.ubuntu-fr.org/rootkit

sudo apt-get install rkhunter
sudo rkhunter --update
sudo rkhunter --version

sudo rkhunter --checkall --report-warnings-only

sudo apt-get install chkrootkit
sudo chkrootkit -V
sudo chkrootkit -q
sudo chkrootkit >/var/log/chkrootkit.log
sudo crontab -e
0 0 * * * /usr/sbin/chkrootkit | ansi2html -l >/var/www/nabla/public/reports/chkrootkit-report.html

# wlp0s20f3: PACKET SNIFFER(/usr/sbin/NetworkManager[1881], /usr/sbin/wpa_supplicant
# https://unix.stackexchange.com/questions/791474/networkmanager-wpa-supplicant-and-wifi7-802-11be
sudo systemctl status wpa_supplicant.service
sudo nano /usr/lib/systemd/system/wpa_supplicant.service
# Add -Dnl80211

# Warning: Hidden directory found
# http://askubuntu.com/questions/1537/rkhunter-warning-about-etc-java-etc-udev-etc-initramfs
sudo nano /etc/rkhunter.conf
# Add Uncomment
# ALLOWHIDDENDIR="/etc/.java"
# ALLOWHIDDENDIR="/dev/.udev"
# ALLOWHIDDENDIR="/dev/.initramfs"
# ALLOWHIDDENFILE=/etc/.gitignore
# ALLOWHIDDENFILE=/etc/.gitkeep

sudo apt-get install tiger
sudo tiger --version

sudo tiger

#check for bad block
sudo apt-get install e2fsprogs
sudo badblocks -v /dev/sda >bad-blocks
#sudo fsck -t ext3 -l bad-blocks /dev/sda

exit 0
