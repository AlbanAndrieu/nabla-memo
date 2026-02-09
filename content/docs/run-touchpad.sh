#!/bin/bash
set -xv

# https://medium.com/@yash9439/how-to-enable-touchpad-gestures-in-ubuntu-22-04-c0ec460c423

sudo add-apt-repository ppa:touchegg/stable
sudo apt install touchegg
# https://github.com/JoseExposito/gnome-shell-extension-x11gestures
sudo apt install gnome-shell-extension-manager

# Navigate to the “Browse” tab and search for the “X11 gestures” extension.

sudo apt remove - autoremove touchegg
sudo add-apt-repository - remove ppa:touchegg/stable

exit 0
