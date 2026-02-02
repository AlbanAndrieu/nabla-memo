#!/bin/bash
set -xv
sudo apt install ecryptfs-utils cryptsetup
sudo adduser encryption_user
sudo usermod -aG sudo encryption_user
sudo apt install ecryptfs-utils
sudo ecryptfs-setup-private
sudo ecryptfs-insert-wrapped-passphrase-into-keyring /home/albanandrieu/.ecryptfs/wrapped-passphrase
sudo ecryptfs-recover-private /home/albanandrieu/.Private
ecryptfs-mount-private /home/albanandrieu/.Private
exit
