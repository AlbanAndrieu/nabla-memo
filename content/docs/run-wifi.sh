#!/bin/bash
set -xv

sudo ifconfig

sudo ifconfig wlan1 down
sudo iwconfig wlan1 mode monitor
sudo ifconfig wlan1 up

sudo apt-get install aircrack-ng

sudo airmon-ng start wlan1

# sudo iwconfig
sudo watch -n1 iwconfig

sudo apt-get install wavemon
wavemon

# watch -n1 journalctl  --since yesterday -xeu tailscaled.service
watch -n1 journalctl -xeu tailscaled.service
#  --since 09:00 --until "1 hour ago"

# wifi stable on NETGEAR75-5G

# Go to router http://172.17.0.12/start.htm
./run-netgear.sh

lspci
# 0000:00:14.3 Network controller: Intel Corporation Wi-Fi 6 AX201 (rev 20)

sudo dmesg | grep iw

cat /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
# Values are 0 (use default), 1 (ignore/don't touch), 2 (disable) or 3 (enable).
# wifi.powersave = 3
sudo sed -i 's/wifi.powersave = 3/wifi.powersave = 2/' /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf && systemctl restart network-manager.service

exit 0
