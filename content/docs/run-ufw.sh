#!/bin/bash
set -xv

#http://vpscoupons.co/configuring-ufw-firewall-on-ubuntu-12-04/

sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 5900
sudo ufw allow ssh

sudo ufw status
sudo ufw app list
cat /etc/services | grep webmin
sudo ufw allow CUPS

sudo ufw allow webmin
#usermin
sudo ufw allow 20000
#sudo ufw allow Samba
sudo ufw allow from 10.0.0.0/8 to 127.0.0.1 app Samba
sudo ufw allow to 10.0.0.0/8 from 127.0.0.1 app Samba
sudo ufw allow from 10.0.0.0/8 to any port 3306/
#sudo ufw allow mysql

#sudo ufw allow ntp

# Allow port 80 (for your webserver to server HTTP).
# sudo ufw allow www
sudo ufw allow 80/tcp
sudo ufw allow http
# Allow port 443 (as we have SSL enabled for our clients security).
sudo ufw allow 443/tcp
sudo ufw allow https
# Allow port 25 (for your Email SMTP)
sudo ufw allow 25/tcp
# synergy barrier
sudo ufw allow 24800
# zabbix agent
sudo ufw allow 10051
# ssh custom port
sudo ufw allow 9922/tcp

# zabbix server
sudo ufw allow 80/tcp
sudo ufw allow 10051/tcp
sudo ufw allow 10050/tcp
sudo ufw allow 10053/tcp

sudo ufw allow ntp

sudo ufw status

#sudo ufw allow from 207.46.232.182

sudo chmod 755 /etc/X11/xinit/xinitrc

sudo service ufw status

sudo netstat -tulpen | grep 64120
sudo lsof -i :64120

# Implement Rate Limiting
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --set
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 -j DROP

exit 0
