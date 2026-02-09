#!/bin/bash
set -xv

# End of Life of YubiKey Manager (GUI) o
# https://developers.yubico.com/yubikey-manager-qt/
# https://developers.yubico.com/yubikey-manager/
# pip install --user yubikey-manager
# sudo apt-add-repository ppa:yubico/stable
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 32CBA1A9
# sudo apt update
# sudo apt install yubikey-manager libpam-yubico libpam-u2f

# yubioath-desktop --log-level DEBUG
# ykman-gui

# Add YubiKey Personalization Tool
# sudo apt install yubikey-personalization-gui yubikey-personalization
# ykinfo -q -s

# Add challenge response https://www.youtube.com/watch?v=r6Qe9Z-kOH0

# sudo apt install yubikey-manager-qt
# ykman
# ykman-gui

# ykman piv access unblock-pin

# https://upgrade.yubico.com/getapikey/
# See https://github.com/hurricanehrndz/ansible-yubikey

# https://github.com/ovh/yubico-piv-checker
# yubico-piv-checker checks that a SSH keypair was generated on device by a Yubikey
# wget https://github.com/ovh/yubico-piv-checker/releases/download/v1.0.1/yubico-piv-checker_1.0.1_amd64.deb
# yubico-piv-checker "$(yubico-piv-tool --action=read-certificate --slot=9a --key-format=SSH)" \
#                      "$(yubico-piv-tool --action=attest --slot=9a)" \
#                      "$(yubico-piv-tool --action=read-certificate --slot=f9)"
#
# sudo apt install yubico-piv-tool
# yubico-piv-tool --action=read-certificate --slot=9a --key-format=SSH

exit 0
