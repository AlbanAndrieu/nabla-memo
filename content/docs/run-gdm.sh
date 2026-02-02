#!/bin/bash
set -xv
sudo nano /etc/gdm3/custom.conf
WaylandEnable=false
sudo systemctl start gdm3.service
sudo dpkg-reconfigure gdm3
exit 0
