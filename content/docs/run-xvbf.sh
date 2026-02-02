#!/bin/bash
set -xv
sudo apt-get install x11-apps
sudo apt-get install xvfb
sudo update-rc.d xvfb defaults 10
echo "to start : /etc/init.d/xvfb start"
exit 0
