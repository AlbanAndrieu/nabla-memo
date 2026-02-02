#!/bin/bash
set -xv
sudo apt-get install ntp
ntpq -p
sudo ntpd -gq
sudo ufw allow ntp
sudo apt remove ntpd chronyd
timedatectl status
timedatectl show-timesync --all
timedatectl list-timezones
sudo timedatectl set-timezone Europe/Paris
sudo apt-get update
sudo apt-get install systemd-timesyncd
cat /etc/systemd/timesyncd.conf
sudo systemctl restart systemd-timesyncd.service
sudo systemctl enable --now systemd-timesyncd
sudo timedatectl set-ntp true
systemctl status ntpd.service
systemctl status chronyd
systemctl stop chronyd
systemctl disable chronyd
systemctl enable ntpd.service
systemctl start ntpd.service
journalctl -b|  grep ntpd
systemctl status ntpd
cat /var/log/messages|  grep ntpd
netstat -tulpn|  grep 123
systemctl status chronyd
timedatectl
timedatectl list-timezones
exit 0
