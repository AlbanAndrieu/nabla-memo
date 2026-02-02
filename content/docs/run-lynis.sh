#!/bin/bash
set -xv
sudo apt-get install lynis grc
sudo apt-get install rkhunter chkrootkit
sudo lynis update info
sudo lynis --version
sudo lynis audit system > /var/log/lynis.log
grc cat /var/log/lynis.log
grep -RIi umask /etc/login.defs
sudo chmod 750 /etc/login.defs
sudo chmod 750 /etc/init.d/rc
echo "blacklist usb-storage"|  sudo tee -a /etc/modprobe.d/blacklist.conf
sudo update-initramfs -u
sudo apt-get install sysstat
sudo nano /etc/default/sysstat
sudo service sysstat restart
sudo apt-get install auditd audispd-plugins
sudo auditctl -l
sudo auditctl -a exit,always -F path=/etc/passwd -F perm=wa
sudo nano /etc/hosts
127.0.0.1 localhost
127.0.1.1 albandri
hostname
hostname -f
sudo dhclient
sudo restart network-manager
sudo geany /etc/ssh/sshd_config
ClientAliveCountMax 2
sudo apt install libpam-tmpdir
sudo apt install colorized-logs
lynis audit system|  ansi2html -l > /var/www/nabla/public/reports/lynis-report.html
sudo crontab -e
0 2 * * 0 /usr/local/lynis/lynis audit system|  ansi2html -l > /var/www/nabla/public/reports/lynis-report.html
exit 0
