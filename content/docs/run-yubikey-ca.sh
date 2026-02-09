#!/bin/bash
set -xv

# See https://smallstep.com/blog/build-a-tiny-ca-with-raspberry-pi-yubikey/

# version 1.2.5 working
ykman info

# https://yubikey-shop.eisn.fr/ressources-et-documentations-yubikey5nfc

# with yubikey manager I generate once RSA2048
# subject nabla
# expired 2036-10-09
# self signed
# management key : default 010203040506070801020304050607080102030405060708

# https://developers.yubico.com/PIV/Guides/Device_setup.html

ykman piv access unblock-pin

ykman piv reset
# Resetting PIV data...
# Reset complete. All PIV data has been cleared from the YubiKey.
# Your YubiKey now has the default PIN, PUK and Management Key:
# 	PIN:	123456
# 	PUK:	12345678
# 	Management Key:	010203040506070801020304050607080102030405060708

ykman piv access change-management-key --generate --protect

# Change the PIN from 123456 to XXX: lastpass : yubikey-5C-nabla
ykman piv access change-pin --pin 123456 --new-pin XXX

# ykman piv keys generate --algorithm ECCP256 9a pubkey.pem
# ykman piv certificates generate --subject "CN=yubico" 9a pubkey.pem

ykman piv certificates import 9a /home/albanandrieu/w/nabla/env/linux/cnf/ca-nabla.cer
# Certificate imported into slot AUTHENTICATION
ykman piv keys import 9a /home/albanandrieu/w/nabla/env/linux/cnf/ca-nabla.key
echo ${ROOT_CA_PASSPHRASE}
# password in laspass :t yubikey-5C-nabla , same echo ${ROOT_CA_PASSPHRASE}

# https://qwerty1q2w.medium.com/yubikey-ssh-authentication-814d34b5e756

# check status
yubico-piv-tool -a status

# issue : YubiKey-Manager GUI doesn't detect Yubikey on Ubuntu 24.04
# qml: qrc:/qml/YubiKey.qml:208: TypeError: Cannot read property 'success' of undefined
ykman --diagnose

sudo apt remove yubico-piv-tool
# Update the package
# ll /usr/lib/x86_64-linux-gnu/libykpiv.so.2
# ll /usr/lib/x86_64-linux-gnu/libykpiv.so.2.2.0
sudo apt --fix-broken install
sudo apt autoremove

exit 0
