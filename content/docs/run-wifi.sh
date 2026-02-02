#!/bin/bash
set -xv
sudo ifconfig
sudo ifconfig wlan1 down
sudo iwconfig wlan1 mode monitor
sudo ifconfig wlan1 up
sudo apt-get install aircrack-ng
sudo airmon-ng start wlan1
sudo watch -n1 iwconfig
sudo apt-get install wavemon
wavemon
watch -n1 journalctl -xeu tailscaled.service
./run-netgear.sh
lspci
sudo dmesg|  grep iw
cat /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
sudo sed -i 's/wifi.powersave = 3/wifi.powersave = 2/' /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf&&  systemctl restart network-manager.service
exit 0
