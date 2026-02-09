#!/bin/bash
#set -xv

# https://doc.ubuntu-fr.org/gnome-screensaver
#sudo apt-get remove xscreensaver-gl cinnamon-screensaver  gnome-screensaver
sudo apt -y install xscreensaver
sudo apt-get -y install xscreensaver-gl-extra xscreensaver-data-extra

# https://wethegeek.com/how-to-install-or-change-screensaver-in-ubuntu/

# https://superuser.com/questions/1469437/disable-auto-lock-screen-on-inactivity-ubuntu-18-04

gsettings get org.gnome.desktop.lockdown disable-lock-screen

gsettings get org.gnome.desktop.screensaver lock-enabled
# gsettings set org.gnome.desktop.screensaver lock-enabled false

gsettings get org.gnome.desktop.screensaver ubuntu-lock-on-suspend
gsettings get org.gnome.desktop.screensaver idle-activation-enabled
gsettings get org.gnome.desktop.session idle-delay
# gsettings set org.gnome.desktop.session idle-delay 0;

gnome-screensaver-command -l
xscreensaver

# Unable to lock: Lock was blocked by an app
# https://discourse.gnome.org/t/how-to-identify-the-app-behind-error-unable-to-lock-lock-was-blocked-by-an-app/22984/5
# Could be due to mouse barrier

systemctl --user list-unit-files
systemctl --user enable xscreensaver.service

exit 0
