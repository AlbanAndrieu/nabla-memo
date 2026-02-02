#!/bin/bash
set -xv
sudo apt install keychain
keychain --stop mine
keychain --stop all
keychain --clear
eval $(keychain --eval)
keychain --agents list
keychain --list
sudo apt-get install gnome-keyring
ll ~/.local/share/keyrings
cd /etc/xdg/autostart/
sudo nano gnome-keyring-ssh.desktop
journalctl -f
./run-secret-tool.sh
exit 0
