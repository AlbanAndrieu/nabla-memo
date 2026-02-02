#!/bin/bash
set -xv
sudo apt-get install openvpn
sudo apt-get install network-manager-openconnect network-manager-openconnect-gnome
sudo apt-get install vpnc network-manager-vpnc
sudo service networking restart
sudo service network-manager restart
sudo nano /etc/default/openvpn
sudo apt install network-manager-gnome
nm-connection-editor
sudo nmcli con show
nmcli con|  grep -i vpn
nmcli con show --active
./run-vpn-jm.sh
sudo service openvpn status
sudo apt install pipx
sudo apt install python3.8-venv
pipx install "openconnect-sso[full]"
pipx ensurepath
source deactivate
openconnect-sso --server parravpn.free.fr --user alban.andrieu@free.fr
sudo service docker restart
exit 0
