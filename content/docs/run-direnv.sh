#!/bin/bash
set -xv

# See https://direnv.net/
sudo apt-get update && sudo apt-get install git make direnv -y

direnv allow

ll .direnv

# https://starship.rs/guide/
curl -sS https://starship.rs/install.sh | sh
mkdir -p ~/.config && touch ~/.config/starship.toml
#wget https://starship.rs/presets/toml/nerd-font-symbols.toml

sudo apt install python3.10-venv

mkdir ~/.config/direnv

# https://github.com/direnv/direnv/wiki/Node
geany ~/.config/direnv/direnvrc

# See https://github.com/direnv/direnv/blob/master/stdlib.sh#L862

exit 0
