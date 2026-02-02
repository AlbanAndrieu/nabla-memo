#!/bin/bash
set -xv
flatpak install flathub com.github.micahflee.torbrowser-launcher -y
tor --version
Tor version 0.4.7.10.
ss -nlt|  grep 9050
ss -nlt|  grep 9150
wget -qO - https://api.ipify.org
torsocks wget -qO - https://api.ipify.org
TOR_HASH=$(tor --hash-password "$TOR_PASSWORD")
printf "HashedControlPassword $TOR_HASH\nControlPort 9051\n"|  sudo tee -a /etc/tor/torrc
sudo usermod -a -G debian-tor $USER
sudo adduser $USER   debian-tor
sudo systemctl restart tor
telnet 127.0.0.1 9051
AUTHENTICATE "TOR_PASSWORD"
SIGNAL NEWNYM
SIGNAL CLEARDNSCACHE
quit
echo -e 'AUTHENTICATE "TOR_PASSWORD"\r\nsignal NEWNYM\r\nQUIT'|  nc 127.0.0.1 9051
sudo apt-get install nyx
exit 0
