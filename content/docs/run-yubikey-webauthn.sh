#!/bin/bash
sudo apt-get install libpam-u2f
mkdir -p ~/.config/Yubico
pamu2fcfg > ~/.config/Yubico/u2f_keys
sudo geany /etc/pam.d/sudo
sudo nano /etc/pam.d/gdm-password
exit 0
