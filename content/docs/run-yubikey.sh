#!/bin/bash
set -xv

# See https://support.yubico.com/hc/en-us/articles/360016649039-Enabling-the-Yubico-PPA-on-Ubuntu

sudo apt purge yubikey*
# sudo apt remove pcsc-tools
pip uninstall yubikey-manager

sudo apt purge pcscd yubioath-desktop libpam-yubico libpam-u2f
# sudo snap install yubioath-desktop
# sudo snap restart yubioath-desktop.pcscd

./run-yubikey-old.sh

# openssl rand -base64 16
# base32
LC_ALL=C tr -dc 'A-Z2-7' </dev/urandom | head -c 32
echo

# Enable smartcard
sudo apt install pcscd
sudo systemctl enable --now pcscd
systemctl status pcscd

sudo systemctl stop pcscd
sudo systemctl stop pcscd.socket

# https://github.com/Yubico/yubioath-flutter/
# https://www.yubico.com/products/yubico-authenticator/
wget https://developers.yubico.com/yubioath-flutter/Releases/yubico-authenticator-latest-linux.tar.gz
./desktop_integration.sh --install

sudo apt install libpam-yubico libpam-u2f
sudo apt install libfido2-1 pamu2fcfg

mkdir -p ~/.config/Yubico
pamu2fcfg >~/.config/Yubico/u2f_keys
# and touch the key

ykpamcfg -2

# For ovh working on Opera, not Chrome

# https://github.com/FiloSottile/yubikey-agent

sudo apt install yubikey-agent
sudo systemctl enable --now pcscd.socket
systemctl --user enable --now yubikey-agent

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/yubikey-agent/yubikey-agent.sock"

yubikey-agent-setup

# sudo apt install opensc-pkcs11 pcscd sssd libpam-sss
# check smart card
p11-kit list-modules
p11tool --list-tokens

pkcs15-tool --list-certificates

# Use yubikey for 2FA storage
# https://les-enovateurs.com/yubikey-double-authentification-installation-ubuntu
# in Yubico Authenticator (32 accounts only)

# You can verify yubikey certificate
# https://documentation.ubuntu.com/server/how-to/security/smart-card-authentication/index.html

yubico-piv-tool -a status

./run-ssh-keygen.sh

# Generate key for yubikey
ssh-keygen -t ecdsa-sk -C "alban.andrieu@free.fr"
# No passphrase
ll /home/albanandrieu/.ssh/id_ecdsa_sk

# https://developers.yubico.com/SSH/Securing_git_with_SSH_and_FIDO2.html

apt-get install ssh-askpass
which ssh-askpass

eval "$(ssh-agent -s)"
ssh-add -K
ssh-add -L
killall ssh-agent
eval "$(
  ssh-agent -s
  export SSH_ASKPASS=/usr/bin/ssh-askpass
)"

mkdir -p ~/.ssh && touch ~/.ssh/allowed_signers
sudo geany ~/.ssh/allowed_signers

# https://qwerty1q2w.medium.com/yubikey-attestation-1addd8d8dbbf
# We can check yubikey attestation

sudo apt-get update
sudo apt-get install opensc

exit 0
