#!/bin/bash
set -xv
sudo apt install aide
sudo touch /var/lib/aide/aide.db
sudo chmod 755 /var/lib/aide/aide.db
sudo aide --config=/usr/share/aide/config/aide/aide.conf --check
systemctl status dailyaidecheck.service
ll /etc/cron.daily/dailyaidecheck
sudo systemctl disable dailyaidecheck.service
/usr/lib/systemd/system/dailyaidecheck.service
sudo systemctl disable dailyaidecheck.timer
exit 0
