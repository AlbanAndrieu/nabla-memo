#!/bin/bash
set -xv

sudo apt update
sudo apt install snapd
sudo snap remove teams-for-linux
rm -Rf ~/.config/skypeforlinux
rm -rf ~/.config/teams
rm -rf ~/.config/Microsoft/Microsoft\ Teams
rm -rf ~/.config/Microsoft\ Teams\ -\ Preview/

sudo snap install teams-for-linux --beta

#See https://forum.snapcraft.io/t/how-can-i-use-snap-when-i-dont-use-home-user/3352
teams-for-linux

sudo dpkg-reconfigure apparmor

sudo nano /etc/apparmor.d/tunables/home.d/my-homes
#@{HOMEDIRS}+=/albandrieu /albandri /jenkins
sudo nano /var/lib/snapd/apparmor/snap-confine/my-homes

# https://login.microsoftonline.com/
# alban_andrieu@hotmail.fr

exit 0
