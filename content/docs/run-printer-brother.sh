#!/bin/bash
set -xv
/etc/init.d/cups restart
sudo systemctl enable cups.service
echo 192.168.3.196
exit 0
