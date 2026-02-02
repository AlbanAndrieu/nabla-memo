#!/bin/bash
set -xv
sudo apt-get install clamav-base clamav-daemon clamav-docs clamav
sudo apt-get install clamtk-gnome
sudo apt install clamav clamav-daemon
freshclam
clamscan
clamscan -r /home/albandrieu
clamscan -r /
netstat -tlpn|  grep clam
tail -f /var/log/clamav/freshclam.log
sudo apt-get install inotify-tools
./run-clamav-tr.sh
sudo clamscan --max-filesize=3999M --max-scansize=3999M --exclude-dir=/kgr/* --exclude-dir=/home/* --exclude-dir=/sys/* --exclude-dir=/proc/* -i -r /
sudo clamscan -i -r --alert-encrypted=yes --alert-encrypted-archive=yes --alert-macro=yes --alert-encrypted-doc=yes --alert-phishing-ssl=yes --alert-phishing-cloak=yes /home
clamscan --infected
less /etc/clamav/freshclam.conf
netstat -anp|  grep -E "(Active|State|clam|3310)"
sudo nano /etc/clamav/clamd.conf
systemctl restart clamav-daemon.service
sudo clamd ping
clamdtop
sudo nano /etc/cron.monthly/clam_scan
clamscan --max-filesize=3999M --max-scansize=3999M --exclude-dir=/media/* --exclude-dir=/home/test/* --exclude-dir=/sys/* --exclude-dir=/proc/* -i -r / >> /var/log/clamav/clamav-cron-albandrieu.log
telnet 192.168.1.25 3310
sudo mkdir /var/log/clamav/
sudo touch /var/log/clamav/clamav.log
sudo service logrotate restart
exit 0
