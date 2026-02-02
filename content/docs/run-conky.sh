#!/bin/bash
set -xv
$HOME/.conky/conky-startup.sh
sudo add-apt-repository ppa:ubuntuhandbook1/conkymanager2
sudo apt install conky-manager2
sudo systemctl daemon-reload
sudo service conky status
watch -n1 journalctl -xeu conky.service
journalctl -xeu conky.service
systemctl --user status conky.service
systemctl --user status conky.timer
exit 0
