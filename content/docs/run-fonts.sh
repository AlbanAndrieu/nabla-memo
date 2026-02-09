#!/bin/bash
#set -xv

# https://linuxconfig.org/how-to-install-fonts-on-ubuntu-20-04-focal-fossa-linux

sudo apt install font-manager

# See https://github.com/microsoft/cascadia-code/wiki/Installing-Cascadia-Code
#wget -O ~/Downloads/CascadiaCode-2111.01.zip https://github.com/microsoft/cascadia-code/releases/download/v2111.01/CascadiaCode-2111.01.zip
#wget -O ~/Downloads/bitwise.zip https://www.1001freefonts.com/d/8190/bitwise.zip
#unzip -p ~/Downloads/bitwise.zip Bitwise.ttf > ~/Downloads/Bitwise.ttf
#rm ~/Downloads/bitwise.zip

# https://github.com/tonsky/FiraCode/wiki/Linux-instructions#installing-with-a-package-manager
sudo apt-get install --reinstall fonts-emojione fonts-firacode fonts-font-awesome

# See https://www.nerdfonts.com/
# https://vorillaz.github.io/devicons/#/dafont
# wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/3270.zip
cdr
git clone git@github.com:ryanoasis/nerd-fonts.git

cd nerd-fonts/
git checkout master

./install.sh

#https://github.com/microsoft/vscode-codicons
#npm i @vscode/codicons

sudo apt-get install fonts-arphic-uming fonts-arphic-gbsn00lp # for simple chinese
sudo apt-get install fonts-arphic-uming fonts-arphic-bsmi00lp # for complex chinese
sudo apt-get install fonts-noto-cjk # for noto serif of chinese

# See https://help.ubuntu.com/community/Fonts#Chinese.2C_Japanese.2C_and_Korean_Fonts
# Cyrillic fonts are messing starship
sudo apt-get remove "fonts-arphic-*"
sudo apt-get remove xfonts-cyrillic
apt list --installed | grep fonts
ll /usr/share/fonts

fc-cache -f

./run-locale.sh

# sudo apt-get install gsfonts fonts-symbola fonts-xfree86-nonfree fonts-smc
# sudo apt-get install fonts-tlwg-mono-otf fonts-telu fonts-orya-extra fonts-navilu fonts-guru-extra fonts-firacode fonts-deva-extra fonts-dejavu-extra
# sudo apt-get install texlive-fonts-recommended fonts-sahadeva fonts-yrsa-rasa
# sudo apt install ttf-ancient-fonts ttf-mscorefonts-installer
# sudo apt install fonts-glyphicons-halflings fonts-emojione

sudo apt-get install --reinstall python3-debian

ll ~/.fonts
ll ~/.local/share/fonts

echo "  "

exit 0
