#!/bin/bash
set -xv

# See https://doc.ubuntu-fr.org/appimage

wget https://download.live.ledger.com/latest/linux
sudo apt install libfuse2

sudo chmod a+x ./ledger-live-desktop-2.51.0-linux-x86_64.AppImage
/home/albandrieu/ledger-live-desktop-2.51.0-linux-x86_64.AppImage --install

sudo mkdir ledger
sudo chown -R albandrieu:albandrieu /data/ledger/
mv ledger-live-desktop-2.75.0-linux-x86_64.AppImage /data/ledger/
ln -s /data/ledger/ledger-live-desktop-2.75.0-linux-x86_64.AppImage ~/ledger-live-desktop.AppImage

wget -q -O - https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh | sudo bash

# See https://7labs.io/tips-tricks/ledger-wallet-as-usb-security-key.html

# Need FIDO U2F

# Yubico YubiKey 5 Series gets
# FIDO (U2F), FIDO2
# WebAuthn, CTAP 1, CTAP 2, U2F, smart card, Yubico OTP, OATH (HOTP/TOTP), OpenPGP, secure static passwords

# Add SSH/PGP Agent, OpenPGP.XL, FIDO U2F

# See https://blog.ledger.com/ssh/
# See https://dud225.github.io/LedgerHQ.github.io/ssh-with-openpgp-card-app/

sudo apt install pcscd pcsc-tools python3 # libusb
pip3 install ledger_agent==0.9.0

ledger-agent username@hostname

#copy it to $HOME/.ssh/authorized_keys

echo "<ssh://username@hostname|nist256p1>" >"$HOME/.ssh/nanox-keys.conf.pub"

# https://github.com/romanz/trezor-agent/blob/master/doc/README-SSH.md
ledger-agent albandrieu@albandrieu -v >hostname.pub
ledger-agent -v -e ed25519 git@github.com >~/.ssh/github.pub

ledger-agent albandrieu@albandrieu -v -s
ssh-add -L

ssh root@nabla
ssh root@home.albandrieu.com

# https://dud225.github.io/LedgerHQ.github.io/ssh-with-openpgp-card-app/
#sudo apt install pcscd pcsc-tools
#sudo apt install scdaemon
sudo apt install pcscd scdaemon gnupg2 pcsc-tools -y

geany ~/.gnupg/scdaemon.conf
# Add
enable-pinpad-varlen

pcsc_scan -r
# 0: Ledger Nano X [Nano X] (0001) 00 00

# YubiKey https://blog.programster.org/yubikey-link-with-gpg
pcsc_scan -n

gpg --card-status
gpg --edit-card

# FIDO U2F
# See https://7labs.io/tips-tricks/ledger-wallet-as-usb-security-key.html

exit 0
