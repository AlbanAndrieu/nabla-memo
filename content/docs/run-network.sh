#!/bin/bash
set -xv
sudo netplan apply
sudo service NetworkManager restart
sudo service systemd-networkd status
sudo service warp-svc status
sudo systemctl disable warp-svc.service
sudo docker run --rm -it -p 10000:8000 weshigbee/requestbin
sudo apt-get install etherape iptraf-ng nload avahi-utils iperf fping
avahi-publish -a albandrieu-Latitude-5420.work.local -R 192.168.3.189
iftop
iptraf
mtr google.com
nload
iperf -c 10.30.10.85
fping - a -g 10.30.10.85 10.30.10.86
nc -l 8080
sudo nano /etc/systemd/resolved.conf
sudo systemctl restart systemd-resolved.service
ip link show
sudo service NetworkManager status
journalctl|  cat --number
watch -n1 journalctl -xeu NetworkManager.service
sudo service tailscaled restart
exit 0
