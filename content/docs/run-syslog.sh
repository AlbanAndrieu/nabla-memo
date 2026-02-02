#!/bin/bash
set -xv
sudo apt purge syslog-ng syslog-ng-core
sudo rm -Rf /var/crash/*
sudo geany /etc/syslog-ng/syslog-ng.conf
sudo apt install rsyslog rsyslog-pgsql rsyslog-mongodb rsyslog-doc rsyslog-openssl
sudo geany /etc/rsyslog.conf
$AllowedSender TCP, 127.0.0.1, 192.168.10.0/24, 172.17.0.0/24, *.albandrieu.com
*.info
mail.none
authpriv.none
cron.none
authpriv.none
*.emerg @172.17.0.57:5140
local6.* @172.17.0.57:5140
rsyslogd -v
sudo systemctl status rsyslog
ss -tunelp|  grep 514
sudo ss -tulnp|  grep "rsyslog"
sudo ufw allow 514/tcp
sudo ufw allow 514/udp
sudo systemctl disable rsyslog
sudo tail /var/log/syslog
exit 0
