#!/bin/bash
set -xv
sudo apt-get install screen xvfb
wget https://download2.rapid7.com/download/InsightVM/Rapid7Setup-Linux64.bin
sudo chmod +x NeXposeSetup-Linux64.bin
sudo ./NeXposeSetup-Linux64.bin
/opt/rapid7/nexpose
ll /etc/systemd/system/nexposeconsole.service
sudo systemctl start nexposeconsole.service
cd /opt/rapid7/nexpose/nsc
ll /opt/rapid7/nexpose/nsc/conf/userdb.xml
systemctl start nexposeconsole
exit 0
