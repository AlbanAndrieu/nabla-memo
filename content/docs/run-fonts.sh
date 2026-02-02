#!/bin/bash
sudo apt install font-manager
sudo apt-get install --reinstall fonts-emojione fonts-firacode fonts-font-awesome
cdr
git clone git@github.com:ryanoasis/nerd-fonts.git
cd nerd-fonts/
git checkout master
./install.sh
sudo apt-get install fonts-arphic-uming fonts-arphic-gbsn00lp
sudo apt-get install fonts-arphic-uming fonts-arphic-bsmi00lp
sudo apt-get install fonts-noto-cjk
sudo apt-get remove "fonts-arphic-*"
sudo apt-get remove xfonts-cyrillic
apt list --installed|  grep fonts
ll /usr/share/fonts
fc-cache -f
./run-locale.sh
sudo apt-get install --reinstall python3-debian
ll ~/.fonts
ll ~/.local/share/fonts
echo "  "
exit 0
