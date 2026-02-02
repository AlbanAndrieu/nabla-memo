#!/bin/bash
set -xv
sudo add-apt-repository ppa:peterlevi/ppa
sudo apt-get update
sudo apt-get install variety
flatpak install flathub com.ktechpit.colorwall
exit 0
