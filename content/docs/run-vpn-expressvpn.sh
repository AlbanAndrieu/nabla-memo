#!/bin/bash
set -xv
cd ~/Downloads/
sudo dpkg -i expressvpn_3.17.0.8-1_amd64.deb
expressvpn activate
expressvpn install-chrome-extension
expressvpn connect smart
expressvpn status
expressvpn preferences set network_lock off
expressvpn preferences set block_trackers true
expressvpn disconnect
expressvpn autoconnect true
firefox https://ipchicken.com/
nmcli dev show|  grep 'IP4.DNS'
route -n
exit 0
