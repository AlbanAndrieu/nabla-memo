#!/bin/bash

# Authy is no more delivered on Ubuntu

# https://flathub.org/apps/com.belmoussaoui.Authenticator

flatpak install flathub com.belmoussaoui.Authenticator

flatpak run com.belmoussaoui.Authenticator

# git clone https://github.com/Korben00/authy-export.git
# cd authy-export
# pip install -r requirements.txt
#
# ./authy-export-linux-amd64-test ~/Desktop/authy-code.txt

exit 0
