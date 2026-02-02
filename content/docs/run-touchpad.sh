#!/bin/bash
set -xv
sudo add-apt-repository ppa:touchegg/stable
sudo apt install touchegg
sudo apt install gnome-shell-extension-manager
sudo apt remove - autoremove touchegg
sudo add-apt-repository - remove ppa:touchegg/stable
exit 0
