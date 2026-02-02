#!/bin/bash
set -xv
sudo apt remove synergy
sudo dpkg --install synergy-linux_x64-libssl3-v3.0.79.1-rc3.deb
ps -edf|  grep synergy
killall synergy-service
killall synergy-coresynergy-service
killall synergy-config
sudo mkdir -p /var/log/synergy
sudo chown albandrieu:albandrieu
tail -f /var/log/synergy/synergy-core.log
locate synergy.conf
nano /var/lib/synergy/synergy.conf
sudo systemctl restart synergy
sudo systemctl disable synergy
exit 0
