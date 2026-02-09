#!/bin/bash
set -xv

# sudo apt-get install tor torbrowser-launcher
flatpak install flathub com.github.micahflee.torbrowser-launcher -y

tor --version
Tor version 0.4.7.10.

# By default, Tor runs on port 9050
ss -nlt | grep 9050
ss -nlt | grep 9150

# Test without tor
wget -qO - https://api.ipify.org

# Test with tor
torsocks wget -qO - https://api.ipify.org

#. torsocks on
#source torsocks off

TOR_HASH=$(tor --hash-password "${TOR_PASSWORD}")
printf "HashedControlPassword $TOR_HASH\nControlPort 9051\n" | sudo tee -a /etc/tor/torrc
# geany /usr/share/tor/tor-service-defaults-torrc

sudo usermod -a -G debian-tor ${USER}
sudo adduser ${USER} debian-tor

sudo systemctl restart tor

telnet 127.0.0.1 9051
AUTHENTICATE "TOR_PASSWORD"
SIGNAL NEWNYM
SIGNAL CLEARDNSCACHE
quit

# telnet 172.17.0.24 9150

echo -e 'AUTHENTICATE "TOR_PASSWORD"\r\nsignal NEWNYM\r\nQUIT' | nc 127.0.0.1 9051

# https://en.bitcoin.it/wiki/Fallback_Nodes
# https://bitcoin.stackexchange.com/questions/70069/how-can-i-setup-bitcoin-to-be-anonymous-with-tor

# Tor monitoring https://nyx.torproject.org/#download
sudo apt-get install nyx

exit 0
