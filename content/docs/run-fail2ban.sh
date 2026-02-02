#!/bin/bash
set -xv
sudo apt install fail2ban
sudo fail2ban-client status
sudo apt-get install python3-pip
python3 -m pip install pyasynchat --break-system-packages
sudo apt purge fail2ban
sudo rm -Rf /var/lib/fail2ban
systemctl enable fail2ban
sudo service fail2ban restart
cat /etc/fail2ban/jail.conf
exit 0
