#!/bin/bash
set -xv
sudo apt install git
curl -O https://raw.githubusercontent.com/psyray/nmap-viewer/refs/heads/master/nmap-viewer.sh
chmod +x nmap-viewer.sh
sudo ./nmap-viewer.sh install
./nmap-viewer.sh update
sudo /usr/bin/nmap -sV -O -p- -T4 -A -oX /tmp/lastnmapscan.xml 192.168.1.0/24 -v --stats-every 10s
sudo /usr/bin/nmap -sV -O -p- -T4 -A -oX /tmp/lastnmapscan_lan.xml 172.17.0.57/24 -v --stats-every 10s
./nmap-viewer.sh start
cat /etc/crontab
0 1 * * * /usr/bin/nmap -sV -O -p- -T4 -A --stats-every 10s -oX /tmp/lastnampscan.xml 192.168.1.0/24 -v > /dev/null 2>&1
./run-zenmap.sh
exit 0
