#!/bin/bash
set -xv
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt update
sudo apt install remmina remmina-plugin-rdp remmina-plugin-secret
sudo killall remmina
sudo apt-cache search remmina-plugin
sudo apt install remmina-plugin-rdp remmina-plugin-vnc remmina-plugin-www
gsettings set org.gnome.Vino require-encryption false
la -lrta ~/.config/remmina/
cd ~
tar -czf remmina_backup.tgz .local/share/remmina/ .config/remmina/ .local/share/keyrings .ssh/
exit 0
