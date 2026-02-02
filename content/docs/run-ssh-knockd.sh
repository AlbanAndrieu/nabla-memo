#!/bin/bash
set -xv
sudo apt install knockd
sudo nano /etc/default/knockd
KNOCKD_OPTS="-i eth0"
sudo systemctl restart knockd
exit 0
