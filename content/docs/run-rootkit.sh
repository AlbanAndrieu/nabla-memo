#!/bin/bash
set -xv
sudo apt-get install rkhunter
sudo rkhunter --update
sudo rkhunter --version
sudo rkhunter --checkall --report-warnings-only
sudo apt-get install chkrootkit
sudo chkrootkit -V
sudo chkrootkit -q
sudo chkrootkit > /var/log/chkrootkit.log
sudo crontab -e
0 0 * * * /usr/sbin/chkrootkit|  ansi2html -l > /var/www/nabla/public/reports/chkrootkit-report.html
sudo systemctl status wpa_supplicant.service
sudo nano /usr/lib/systemd/system/wpa_supplicant.service
sudo nano /etc/rkhunter.conf
sudo apt-get install tiger
sudo tiger --version
sudo tiger
sudo apt-get install e2fsprogs
sudo badblocks -v /dev/sda > bad-blocks
exit 0
