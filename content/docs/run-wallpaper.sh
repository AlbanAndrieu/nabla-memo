#!/bin/bash
set -xv

# See https://linuxconfig.org/ubuntu-20-04-wallpaper-slideshow

#wallpaper
#http://peterlevi.com/variety/
sudo add-apt-repository ppa:peterlevi/ppa
sudo apt-get update
sudo apt-get install variety

# https://github.com/flathub/com.ktechpit.colorwall
flatpak install flathub com.ktechpit.colorwall

exit 0
