#!/bin/bash
set -xv

# sudo init 6

top -b -n 1 | head -10

df -h

sudo shutdown --test

wall "Server rebooting in 5 minutes. Please save your work."

sudo shutdown -r +5 "Server rebooting in 5 minutes. Please save your work."

# sudo shutdown -r now

# sudo systemctl reboot

journalctl -xe | grep error

systemctl status apache2

# mysql -u root -p -e "SHOW DATABASES;"

exit 0
