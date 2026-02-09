#!/bin/bash
#set -xv

sudo apt remove libgd3
# colord gnome-control-center gvfs-backends hplip libc-devtools libgd3 libgphoto2-6 libsane1 php7.4-gd sane-utils shotwell simple-scan ubuntu-desktop ubuntu-desktop-minimal

sudo apt-get install ubuntu-release-upgrader-core
sudo do-release-upgrade

journalctl | grep blocked
# gnome-shell[9581]: error: Unable to lock: Lock was blocked by an application

# stacer is locking the screen saver

# https://unix.stackexchange.com/questions/767795/upgrading-ubuntu-server-22-10-kinetic-kudu-to-23-10-mantic

gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

sudo apt install ubuntu-restricted-extras
sudo apt install gnome-shell-extension-ubuntu-tiling-assistant
sudo apt install gnome-software gnome-software-plugin-flatpak flatpak
sudo apt install gnome-weather gnome-clocks

sudo apt install gnome-control-center

gnome-control-center display

# https://forums.developer.nvidia.com/t/error-bad-return-status-for-module-build-on-kernel/166888/3

sudo dkms status
sudo apt-get autoremove --purge nvidia-driver-*
sudo apt-get autoremove --purge nvidia-*
sudo apt-get autoremove --purge xserver-xorg-video-nouveau

sudo apt remove virtualbox-*
sudo apt remove openvpn

#dpkg --configure -a

# ERROR with tzdata-legacy
sudo apt purge gnustep-base-common gnustep-base-runtime gnustep-gui-common tzdata-legacy
sudo apt --fix-broken install
sudo apt-get upgrade
sudo apt-get autoremove

# https://bugs.launchpad.net/ubuntu/+source/sg3-utils/+bug/2039279
sudo dpkg -r libsgutils2-2
sudo apt install libsgutils2-1.46-2

# Issue with ubuntu 23.10 upgrade
# https://forum.ubuntu-fr.org/viewtopic.php?id=2082120
sudo apt remove --simulate libfreetype6-dev libwebkitgtk-6.0-4 libjavascriptcoregtk*
sudo apt remove libfreetype6-dev libwebkitgtk-6.0-4 libjavascriptcoregtk*
sudo apt install gdm3

exit 0
