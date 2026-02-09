#!/bin/bash
#set -x

# security keys Yubikey 4
# standard FIDO U2F (Universal 2nd Factor)

# See https://webauthn.io/

# See https://support.yubico.com/hc/en-us/articles/360016649099-Ubuntu-Linux-Login-Guide-U2F
sudo apt-get install libpam-u2f
mkdir -p ~/.config/Yubico
pamu2fcfg >~/.config/Yubico/u2f_keys
#pamu2fcfg -n >> ~/.config/Yubico/u2f_keys

# For sudo user
sudo geany /etc/pam.d/sudo
#Add the line below after the “@include common-auth” line.
#auth       required   pam_u2f.so

# For gnome login
sudo nano /etc/pam.d/gdm-password
#Add the line below after the “@include common-auth” line.
#auth       optional   pam_u2f.so

# Below used for ???
#sudo nano /etc/pam.d/login
#auth       required   pam_u2f.so

# See https://support.yubico.com/hc/en-us/articles/360018695819-Ubuntu-Linux-20-Login-Guide-Challenge-Response

#sudo apt install libpam-yubico yubikey-manager
#ykpamcfg -2

exit 0
