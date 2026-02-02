#!/bin/bash
set -xv
sudo apt-get update&&  sudo apt-get install git make direnv -y
direnv allow
ll .direnv
curl -sS https://starship.rs/install.sh|  sh
mkdir -p ~/.config&&  touch ~/.config/starship.toml
sudo apt install python3.10-venv
mkdir ~/.config/direnv
geany ~/.config/direnv/direnvrc
exit 0
