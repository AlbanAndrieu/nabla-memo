#!/bin/bash
set -xv
sudo apt purge yubikey*
pip uninstall yubikey-manager
sudo apt purge pcscd yubioath-desktop libpam-yubico libpam-u2f
./run-yubikey-old.sh
LC_ALL=C tr -dc 'A-Z2-7' < /dev/urandom| head -c 32
echo
sudo apt install pcscd
sudo systemctl enable --now pcscd
systemctl status pcscd
sudo systemctl stop pcscd
sudo systemctl stop pcscd.socket
wget https://developers.yubico.com/yubioath-flutter/Releases/yubico-authenticator-latest-linux.tar.gz
./desktop_integration.sh --install
sudo apt install libpam-yubico libpam-u2f
sudo apt install libfido2-1 pamu2fcfg
mkdir -p ~/.config/Yubico
pamu2fcfg > ~/.config/Yubico/u2f_keys
ykpamcfg -2
sudo apt install yubikey-agent
sudo systemctl enable --now pcscd.socket
systemctl --user enable --now yubikey-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/yubikey-agent/yubikey-agent.sock"
yubikey-agent-setup
p11-kit list-modules
p11tool --list-tokens
pkcs15-tool --list-certificates
yubico-piv-tool -a status
./run-ssh-keygen.sh
ssh-keygen -t ecdsa-sk -C "alban.andrieu@free.fr"
ll /home/albanandrieu/.ssh/id_ecdsa_sk
apt-get install ssh-askpass
which ssh-askpass
eval "$(ssh-agent -s)"
ssh-add -K
ssh-add -L
killall ssh-agent
eval "$(ssh-agent -s
  export SSH_ASKPASS=/usr/bin/ssh-askpass)"
mkdir -p ~/.ssh&&  touch ~/.ssh/allowed_signers
sudo geany ~/.ssh/allowed_signers
sudo apt-get update
sudo apt-get install opensc
exit 0
