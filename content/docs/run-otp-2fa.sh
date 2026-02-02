#!/bin/bash
set -xv
sudo apt-get install libpam-oath
sudo nano /etc/pam.d/sshd
@include common-auth
auth sufficient pam_oath.so usersfile=/etc/users.oath window=10 digits=6
sudo touch /etc/users.oath
sudo chmod go-rw /etc/users.oath
sudo apt install libpam-google-authenticator
google-authenticator -t -d -f -r 3 -R 30 -W
sudo apt-get install oathtool caca-utils qrencode
git clone https://github.com/mcepl/gen-oath-safe.git
gen-oath-safe/gen-oath-safe aandrieu totp
sudo nano /etc/ssh/sshd_config
sudo systemctl restart sshd.service
exit 0
