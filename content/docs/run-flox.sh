#!/bin/bash
wget https://downloads.flox.dev/by-env/stable/deb/flox-1.8.1.x86_64-linux.deb
sudo dpkg -i flox_1.8.1_*.deb
sudo apt --only-upgrade install flox
exit 0
