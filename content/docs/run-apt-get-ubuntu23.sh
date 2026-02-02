#!/bin/bash
sudo apt remove libgd3
sudo apt-get install ubuntu-release-upgrader-core
sudo do-release-upgrade
journalctl|  grep blocked
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
sudo apt install ubuntu-restricted-extras
sudo apt install gnome-shell-extension-ubuntu-tiling-assistant
sudo apt install gnome-software gnome-software-plugin-flatpak flatpak
sudo apt install gnome-weather gnome-clocks
sudo apt install gnome-control-center
gnome-control-center display
sudo dkms status
sudo apt-get autoremove --purge nvidia-driver-*
sudo apt-get autoremove --purge nvidia-*
sudo apt-get autoremove --purge xserver-xorg-video-nouveau
sudo apt remove virtualbox-*
sudo apt remove openvpn
sudo apt purge gnustep-base-common gnustep-base-runtime gnustep-gui-common tzdata-legacy
sudo apt --fix-broken install
sudo apt-get upgrade
sudo apt-get autoremove
sudo dpkg -r libsgutils2-2
sudo apt install libsgutils2-1.46-2
sudo apt remove --simulate libfreetype6-dev libwebkitgtk-6.0-4 libjavascriptcoregtk*
sudo apt remove libfreetype6-dev libwebkitgtk-6.0-4 libjavascriptcoregtk*
sudo apt install gdm3
exit 0
