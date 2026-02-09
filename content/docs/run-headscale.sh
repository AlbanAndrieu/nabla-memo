#!/bin/bash
set -xv

sudo apt-get install tailscale

sudo tailscale down
sudo tailscale up --login-server https://vpn.jusmundi.com:943 --accept-routes --accept-dns --advertise-connector --advertise-tags=tag:connector --operator=$USER

# Same as
alias jmvpn
# sudo tailscale up --login-server https://vpn.jusmundi.com:943 --accept-routes --accept-dns --force-reauth --reset
sudo tailscale status

sudo tailscale logout

----------

headscale users list
headscale preauthkeys create --user subrouter

sudo tailscale up \
  --login-server https://vpn.jusmundi.com:943/ \
  --hostname=gra1subrouter1 \
  --auth-key ${TAILSCALE_KEY}
--force-reauth \
  --reset \
  --advertise-routes=10.10.0.0/24,10.11.0.0/24,10.20.0.0/24,10.21.0.0/24,10.30.0.0/24,10.31.0.0/24,10.30.10.0/24

sudo tailscale set --advertise-routes=10.10.0.0/24,10.11.0.0/24,10.20.0.0/24,10.21.0.0/24,10.30.0.0/24,10.31.0.0/24,10.30.10.0/24

headscale routes enable -r 22
headscale routes enable -r 22
...

headscale routes list

headscale nodes delete -i 42

taiscale set --accept-route
# tailscale set --accept-dns=false
#
# sudo mkdir /etc/tailscale/
# sudo nano /etc/tailscale/tailscale.conf
# "dns": ["10.30.10.3", "10.30.10.4"]

sudo systemctl restart systemd-resolved
sudo systemctl restart NetworkManager
sudo systemctl restart tailscaled

nslookup jusmundi.com 10.30.10.4
dig -x 10.30.10.200 @10.30.10.4

# https://tailscale.com/kb/1320/performance-best-practices#ethtool-configuration

NETDEV=$(ip route show 0/0 | cut -f5 -d' ')
sudo ethtool -K $NETDEV rx-udp-gro-forwarding on rx-gro-list off

# https://tailscale.com/kb/1019/subnets?tab=linux#enable-ip-forwarding

echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf

########

printf '#!/bin/sh\n\nethtool -K %s rx-udp-gro-forwarding on rx-gro-list off \n' "$(ip route show 0/0 | cut -f5 -d" ")" | sudo tee /etc/networkd-dispatcher/routable.d/50-tailscale
sudo chmod 755 /etc/networkd-dispatcher/routable.d/50-tailscale

sudo /etc/networkd-dispatcher/routable.d/50-tailscale
test $? -eq 0 || echo 'An error occurred.'

#########

# A web ui
# https://github.com/iFargle/headscale-webui/blob/main/SETUP.md
poetry install --only main
poetry run gunicorn -b 0.0.0.0:5000 server:app

# http://localhost:5000/admin

# See https://wiki.opensourceisawesome.com/books/headscale-for-wireguard/page/headscale-tailscale-clients#bkmrk-is-there-a-linux-gui

exit 0
