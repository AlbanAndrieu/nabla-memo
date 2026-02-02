#!/bin/bash
set -xv
sudo apt purge google-chrome-stable
rm -r ~/.config/google-chrome/OptGuideOnDeviceModel
rm -r ~/.config/google-chrome/Default/
rm -r ~/.config/google-chrome/Profile\ 7/
rm -r ~/.config/google-chrome/
rm -r ~/.cache/google-chrome/
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
gnome-keyring-daemon --start --replace --foreground --components=secrets,ssh,pcks11&
mv ~/.config/google-chrome ~/.config/google-chrome-SAV
/usr/bin/google-chrome
exit 0
