#!/bin/bash
set -xv
sudo systemctl disable falcon-sensor
service falcon-sensor status
sudo /opt/CrowdStrike/falconctl -g --cid
sudo /opt/CrowdStrike/falconctl -s --cid=a0ddf149ed9147c9844e012249585dd9
sudo apt-get purge falcon-sensor
exit 0
