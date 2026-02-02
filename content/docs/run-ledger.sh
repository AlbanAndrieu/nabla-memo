#!/bin/bash
set -xv
wget https://download.live.ledger.com/latest/linux
sudo apt install libfuse2
sudo chmod a+x ./ledger-live-desktop-2.51.0-linux-x86_64.AppImage
/home/albandrieu/ledger-live-desktop-2.51.0-linux-x86_64.AppImage --install
sudo mkdir ledger
sudo chown -R albandrieu:albandrieu /data/ledger/
mv ledger-live-desktop-2.75.0-linux-x86_64.AppImage /data/ledger/
ln -s /data/ledger/ledger-live-desktop-2.75.0-linux-x86_64.AppImage ~/ledger-live-desktop.AppImage
wget -q -O - https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh|  sudo bash
sudo apt install pcscd pcsc-tools python3
pip3 install ledger_agent==0.9.0
ledger-agent username@hostname
echo "<ssh://username@hostname|nist256p1>" > "$HOME/.ssh/nanox-keys.conf.pub"
ledger-agent albandrieu@albandrieu -v > hostname.pub
ledger-agent -v -e ed25519 git@github.com > ~/.ssh/github.pub
ledger-agent albandrieu@albandrieu -v -s
ssh-add -L
ssh root@nabla
ssh root@home.albandrieu.com
sudo apt install pcscd scdaemon gnupg2 pcsc-tools -y
geany ~/.gnupg/scdaemon.conf
enable-pinpad-varlen
pcsc_scan -r
pcsc_scan -n
gpg --card-status
gpg --edit-card
exit 0
