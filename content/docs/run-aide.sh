#!/bin/bash
set -xv

# Use File Integrity Monitoring (FIM)
sudo apt install aide

# sudo aideinit

sudo touch /var/lib/aide/aide.db
sudo chmod 755 /var/lib/aide/aide.db
sudo aide --config=/usr/share/aide/config/aide/aide.conf --check

# sudo crontab -e
# 0 3 * * * /usr/bin/aide --config=/usr/share/aide/config/aide/aide.conf  --check > /var/log/cron-aide.log

systemctl status dailyaidecheck.service

ll /etc/cron.daily/dailyaidecheck

sudo systemctl disable dailyaidecheck.service
/usr/lib/systemd/system/dailyaidecheck.service
sudo systemctl disable dailyaidecheck.timer

exit 0
