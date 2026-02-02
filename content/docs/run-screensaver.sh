#!/bin/bash
sudo apt -y install xscreensaver
sudo apt-get -y install xscreensaver-gl-extra xscreensaver-data-extra
gsettings get org.gnome.desktop.lockdown disable-lock-screen
gsettings get org.gnome.desktop.screensaver lock-enabled
gsettings get org.gnome.desktop.screensaver ubuntu-lock-on-suspend
gsettings get org.gnome.desktop.screensaver idle-activation-enabled
gsettings get org.gnome.desktop.session idle-delay
gnome-screensaver-command -l
xscreensaver
systemctl --user list-unit-files
systemctl --user enable xscreensaver.service
exit 0
