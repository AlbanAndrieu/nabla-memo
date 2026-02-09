#!/bin/bash
set -xv

# https://nmap.org/book/inst-linux.html

sudo apt-get install alien
wget https://nmap.org/dist/zenmap-7.94-1.noarch.rpm
# NOK wget https://nmap.org/dist/zenmap-7.95-1.noarch.rpm
sudo alien zenmap-7.94-1.noarch.rpm
sudo dpkg --install zenmap_7.94-2_all.deb

scp ~/Downloads/zenmap_7.94-2_all.deb ubuntu@gra1crowdsec1:~

sudo apt-get install libgtk-3-dev libcanberra-gtk-module
# ModuleNotFoundError: No module named 'cairo'
sudo apt install python3-cairo

sudo su - root
pip install pycairo
zenmap
# 10.30.10.254/24

# Intense scan, all TCP ports
nmap -p 1-65535 -T4 -A -v 192.168.1.0-255

nmap -T4 -F 192.168.0.0-255

# NSE Script
# https://nmap.org/nsedoc/scripts/

# angryip scanner https://angryip.org/download/#linux

ipscan
scp ~/Downloads/zenmap_7.94-2_all.deb ubuntu@gra1crowdsec1:~

exit 0
