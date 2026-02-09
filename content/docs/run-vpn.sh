#!/bin/bash
set -xv

sudo apt-get install openvpn
sudo apt-get install network-manager-openconnect network-manager-openconnect-gnome
#reinstall
#sudo apt-get install --reinstall network-manager-iodine network-manager-openconnect network-manager-openvpn network-manager-pptp network-manager-strongswan network-manager-vpnc

#http://www.humans-enabled.com/2011/06/how-to-connect-ubuntu-linux-to-cisco.html
#then in network manager click add
#Then Cisco AnyConnect Compatible VPN openconnect

sudo apt-get install vpnc network-manager-vpnc

sudo service networking restart
sudo service network-manager restart
#A reboot is required
#sudo reboot

sudo nano /etc/default/openvpn

# See https://gist.github.com/plembo/26027128bc7cbdbb0b967a2fb275da50

sudo apt install network-manager-gnome

# Add search to VPN
nm-connection-editor

sudo nmcli con show

nmcli con | grep -i vpn
nmcli con show --active

./run-vpn-jm.sh

sudo service openvpn status

# Check IP https://www.hostip.fr/

# See https://github.com/vlaci/openconnect-sso

#pip install --user pipx
sudo apt install pipx
sudo apt install python3.8-venv
pipx install "openconnect-sso[full]"
pipx ensurepath
source deactivate
openconnect-sso --server parravpn.free.fr --user alban.andrieu@free.fr
sudo service docker restart

exit 0
