#!/bin/bash
set -xv

# ubuntu logitech mx plus

# https://www.logitech.com/en-us/promo/mxsetup/keyboard-setup/wireless-receiver.html

sudo dpkg-reconfigure keyboard-configuration

setxkbmap -print
setxkbmap -query

# https://askubuntu.com/questions/714764/how-do-i-change-the-keyboard-layout-used-when-entering-in-my-sda-crypt-password
sudo nano /etc/default/keyboard

XKBMODEL="logiultraxc"
XKBLAYOUT="fr"
XKBVARIANT=""
XKBOPTIONS="compose:rctrl"

BACKSPACE="guess"

# https://github.com/spxak1/weywot/blob/main/guides/mxkeys_linux.md

# https://doc.ubuntu-fr.org/solaar

sudo add-apt-repository ppa:solaar-unifying/stable -y && sudo apt update
sudo apt install solaar #solaar-gnome3
sudo solaar

geany ~/.config/solaar/rules.yaml

exit 0
