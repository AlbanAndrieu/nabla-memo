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
teams-for-linux
sudo dpkg-reconfigure apparmor
sudo nano /etc/apparmor.d/tunables/home.d/my-homes
sudo nano /var/lib/snapd/apparmor/snap-confine/my-homes
exit 0
