#!/bin/bash
set -xv

# http://doc.ubuntu-fr.org/conky

$HOME/.conky/conky-startup.sh

# sudo add-apt-repository --remove ppa:ubuntuhandbook1/conkymanager2
sudo add-apt-repository ppa:ubuntuhandbook1/conkymanager2
sudo apt install conky-manager2
# sudo apt remove --autoremove conky conky-manager2

# sudo systemctl --user status conky.service
sudo systemctl daemon-reload
sudo service conky status

watch -n1 journalctl -xeu conky.service
journalctl -xeu conky.service

systemctl --user status conky.service
systemctl --user status conky.timer

exit 0
