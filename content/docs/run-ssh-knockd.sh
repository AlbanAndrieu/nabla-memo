#!/bin/bash
set -xv

# https://jay75chauhan.medium.com/%EF%B8%8Fsecure-linux-server-1bbbaaa465d6

sudo apt install knockd

sudo nano /etc/default/knockd
# KNOCKD_OPTS="-i wlp0s20f3"
KNOCKD_OPTS="-i eth0" # or eno1

sudo systemctl restart knockd

exit 0
