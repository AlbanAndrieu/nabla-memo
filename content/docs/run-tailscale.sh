#!/bin/bash
set -xv
curl -fsSL https://tailscale.com/install.sh|  sh
sudo tailscale logout
sudo tailscale down
./run-headscale.sh
tailscale status|  grep 100|  wc -l|  grep -v offline
sudo tailscale down
sudo service tailscaled restart
sudo tailscale up --login-server https://vpn.jusmundi.com:943/ --hostname=gra1subrouter1 --force-reauth --advertise-routes=10.10.0.0/24,10.11.0.0/24,10.20.0.0/24,10.21.0.0/24,10.30.0.0/24,10.31.0.0/24,10.30.10.0/24,130.84.132.16/32,130.84.132.17/32,130.84.132.18/32,130.84.132.19/32,130.84.132.128/32 --accept-routes=true
sudo tailscale up --login-server https://vpn.jusmundi.com:943/ --hostname=gra1subrouter2 --force-reauth --advertise-routes=10.10.0.0/24,10.11.0.0/24,10.20.0.0/24,10.21.0.0/24,10.30.0.0/24,10.31.0.0/24,10.30.10.0/24,130.84.132.16/32,130.84.132.17/32,130.84.132.18/32,130.84.132.19/32,130.84.132.128/32 --accept-routes=true
./run-flatpak.sh
Add startup application
tailscale completion bash > /etc/bash_completion.d/tailscale
tailscale set --auto-update
cat /usr/lib/systemd/system/tailscaled.service
sudo service tailscaled status
tailscale netcheck
cat /etc/networkd-dispatcher/routable.d/50-tailscale
rm /etc/networkd-dispatcher/routable.d/50-tailscale
sudo service tailscaled restart
sudo systemctl restart tailscaled systemd-resolved
sudo service tailscaled status
sudo systemctl enable tailscaled.service
sudo nmcli con show
nm-connection-editor
tailscale web
file='/etc/wireguard/wg0.conf'
sudo nmcli connection import type wireguard file "$file"
nmcli connection modify wg0 connection.id "mum-office-vpn"
exit 0
