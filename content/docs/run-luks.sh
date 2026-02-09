#!/bin/bash
set -xv

# https://jumpcloud.com/blog/how-to-enable-full-disk-encryption-ubuntu-22-04

sudo apt install ecryptfs-utils cryptsetup

sudo adduser encryption_user
sudo usermod -aG sudo encryption_user

sudo apt install ecryptfs-utils
# IN BW : ecryptfs-setup-private
sudo ecryptfs-setup-private

# warning: could not open directory '.Private/': Permission denied
# warning: could not open directory 'Private/': Permission denied
# warning: could not open directory '.ecryptfs/': Permission denied

sudo ecryptfs-insert-wrapped-passphrase-into-keyring /home/albanandrieu/.ecryptfs/wrapped-passphrase
sudo ecryptfs-recover-private /home/albanandrieu/.Private
# Enter your MOUNT passphrase:
# IN BW : ecryptfs-setup-private
ecryptfs-mount-private /home/albanandrieu/.Private

exit
