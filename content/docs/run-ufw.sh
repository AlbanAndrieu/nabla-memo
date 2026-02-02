#!/bin/bash
set -xv
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 5900
sudo ufw allow ssh
sudo ufw status
sudo ufw app list
cat /etc/services|  grep webmin
sudo ufw allow CUPS
sudo ufw allow webmin
sudo ufw allow 20000
sudo ufw allow from 10.0.0.0/8 to 127.0.0.1 app Samba
sudo ufw allow to 10.0.0.0/8 from 127.0.0.1 app Samba
sudo ufw allow from 10.0.0.0/8 to any port 3306/
sudo ufw allow 80/tcp
sudo ufw allow http
sudo ufw allow 443/tcp
sudo ufw allow https
sudo ufw allow 25/tcp
sudo ufw allow 24800
sudo ufw allow 10051
sudo ufw allow 9922/tcp
sudo ufw allow 80/tcp
sudo ufw allow 10051/tcp
sudo ufw allow 10050/tcp
sudo ufw allow 10053/tcp
sudo ufw allow ntp
sudo ufw status
sudo chmod 755 /etc/X11/xinit/xinitrc
sudo service ufw status
sudo netstat -tulpen|  grep 64120
sudo lsof -i :64120
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --set
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 -j DROP
exit 0
