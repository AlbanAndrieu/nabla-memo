#!/bin/bash
set -xv

telnet 172.17.0.93 24800
nc -vz 172.17.0.93 24800

netstat -anp | grep -E "(Active|State|barrier|24800)"

#iptables -A INPUT -p tcp -i $interface --dport 24800 -j ACCEPT

#https://github.com/debauchee/barrier/issues/190#issuecomment-445582840

# Disable SSL in the config and use VPN IP 10.119.217.12

# https://www.reddit.com/r/linuxquestions/comments/nvmixj/mouse_sharing_on_wayland/
# Disable Wayland
./run-gnome.sh

ll /home/albanandrieu/.local/share/barrier/SSL/Barrier.pem

cd /home/albanandrieu/.local/share/barrier/SSL/
openssl req -new -x509 -sha256 -days 999 -nodes -out Barrier.pem -keyout Barrier.pem

# Disable Wayland
./run-gnome.sh

exit 0
