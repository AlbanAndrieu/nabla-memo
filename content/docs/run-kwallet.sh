#!/bin/bash
set -xv
sudo apt install kgpg kwalletmanager kwalletcli
./run-gpg.sh
nano ~/.config/kwalletrc
exit 0
