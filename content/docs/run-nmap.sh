#!/bin/bash
set -xv

# https://long.sweet.pub/nmap-viewer-visualize-your-network-scans-like-a-pro-for-free-0bfb16807a70
# 01.Connect to your linux with SSH
# 02.Install git package if necessary
sudo apt install git

# 03.Download the installation script from the official github repo
# Note : it is always a good habit to check the content of the script before executing it
# https://github.com/psyray/nmap-viewer
curl -O https://raw.githubusercontent.com/psyray/nmap-viewer/refs/heads/master/nmap-viewer.sh

# 04.Make the script executable:
chmod +x nmap-viewer.sh

# 05.Run the installation script with admin right
sudo ./nmap-viewer.sh install

./nmap-viewer.sh update

##########

#If you do not have one you can run this command
#where /tmp/lastnmapsan will contain the result
# 192.168.1.0/24 is my current network range, adapt it to your's
sudo /usr/bin/nmap -sV -O -p- -T4 -A -oX /tmp/lastnmapscan.xml 192.168.1.0/24 -v --stats-every 10s
sudo /usr/bin/nmap -sV -O -p- -T4 -A -oX /tmp/lastnmapscan_lan.xml 172.17.0.57/24 -v --stats-every 10s

#This command performs a comprehensive network scan:
# -sV: Detects service/version info on open ports
# -O: Attempts to identify the target's operating system
# -p-: Scans all 65535 ports
# -T4: Uses aggressive timing for faster scanning
# -A: Enables OS detection, version scanning, script scanning, and traceroute
# --stats-every 10s: Provides real-time progress updates every 10 seconds
# -oX /tmp/latsssca.xml: Saves results in XML format to the specified file
# 192.168.1.0/24: Scans the entire specified subnet (256 IP addresses)
# -v: Increases verbosity for more detailed output

./nmap-viewer.sh start

##########

cat /etc/crontab
0 1 * * * /usr/bin/nmap -sV -O -p- -T4 -A --stats-every 10s -oX /tmp/lastnampscan.xml 192.168.1.0/24 -v >/dev/null 2>&1

./run-zenmap.sh

exit 0
