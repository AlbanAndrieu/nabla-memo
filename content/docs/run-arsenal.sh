#!/bin/bash
set -xv
python3 -m ensurepip --upgrade
sudo pip install pipx
cd /home/albandrieu/w/jm/github
git clone https://github.com/Orange-Cyberdefense/arsenal.git
cd arsenal
pipx install ./
./run -t -e
arsenal -t -e
git clone git@github.com:stephrobert/arsenal-devops-cheats.git ~/.cheats
exit 0
