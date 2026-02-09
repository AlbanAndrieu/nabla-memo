#!/bin/bash
set -xv

#this will sync localtime with ntp
#there are two dashes before systohc

# /etc/init.d/ntpd stop
# ntpdate timehost
# hwclock --systohc
# hwclock --show
# /etc/init.d/ntpd start

# https://doc.ubuntu-fr.org/ntp
sudo apt-get install ntp

ntpq -p
# https://askubuntu.com/questions/254826/how-to-force-a-clock-update-using-ntp
sudo ntpd -gq

sudo ufw allow ntp

sudo apt remove ntpd chronyd

# https://www.linuxtricks.fr/wiki/systemd-le-ntp-avec-systemd-timesyncd
# New ubuntu
timedatectl status

timedatectl show-timesync --all

timedatectl list-timezones
sudo timedatectl set-timezone Europe/Paris

# https://www.it-connect.fr/configurer-un-client-ntp-sous-linux/
sudo apt-get update
sudo apt-get install systemd-timesyncd

cat /etc/systemd/timesyncd.conf
sudo systemctl restart systemd-timesyncd.service
sudo systemctl enable --now systemd-timesyncd

sudo timedatectl set-ntp true

#On RHEL7 issue conflicts between chronyd and ntpd
#systemctl list-unit-files | grep ntpd
systemctl status ntpd.service
systemctl status chronyd
systemctl stop chronyd
systemctl disable chronyd
#systemctl enable dhcpd.service
#systemctl enable named.service
systemctl enable ntpd.service
#systemctl enable httpd.service
systemctl start ntpd.service

journalctl -b | grep ntpd
systemctl status ntpd
cat /var/log/messages | grep ntpd
netstat -tulpn | grep 123
systemctl status chronyd

#See https://www.certdepot.net/rhel7-set-ntp-service/
timedatectl
timedatectl list-timezones

exit 0
