#!/bin/bash
set -xv
top -b -n 1|  head -10
df -h
sudo shutdown --test
wall "Server rebooting in 5 minutes. Please save your work."
sudo shutdown -r +5 "Server rebooting in 5 minutes. Please save your work."
journalctl -xe|  grep error
systemctl status apache2
exit 0
