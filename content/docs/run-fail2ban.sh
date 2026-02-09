#!/bin/bash
set -xv

sudo apt install fail2ban
sudo fail2ban-client status
# [1189437]: ERROR   No module named 'asynchat
sudo apt-get install python3-pip
# as root
python3 -m pip install pyasynchat --break-system-packages
# File "/usr/lib/python3/dist-packages/pip/__main__.py", line 8, in <module>
#     if sys.path[0] in ("", os.getcwd()):
#                            ^^^^^^^^^^^
# FileNotFoundError: [Errno 2] No such file or directory
# move out of /var/run/fail2ban

sudo apt purge fail2ban
sudo rm -Rf /var/lib/fail2ban

systemctl enable fail2ban
sudo service fail2ban restart

cat /etc/fail2ban/jail.conf

exit 0
