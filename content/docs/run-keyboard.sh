#!/bin/bash
set -xv
sudo dpkg-reconfigure keyboard-configuration
setxkbmap -print
setxkbmap -query
sudo nano /etc/default/keyboard
XKBMODEL="logiultraxc"
XKBLAYOUT="fr"
XKBVARIANT=""
XKBOPTIONS="compose:rctrl"
BACKSPACE="guess"
sudo add-apt-repository ppa:solaar-unifying/stable -y&&  sudo apt update
sudo apt install solaar
sudo solaar
geany ~/.config/solaar/rules.yaml
exit 0
