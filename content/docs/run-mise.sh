#!/bin/bash
set -xv

# https://mise.jdx.dev/getting-started.html
# https://github.com/jdx/mise

sudo rm -rf /usr/local/bin/mise
rm -rf ~/.local/share/mise
rm -rf ~/.local/state/mise
rm -rf ~/.cache/mise

sudo apt update -y && sudo apt install -y gpg sudo wget curl
sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1>/dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
sudo apt update
sudo apt install -y mise

mise --version

sudo apt install --only-upgrade mise

# 2025.11.10 linux-x64 (2025-11-27)
# This version is working with
# python 3.12.10
# poetry 2.2.1
# direnv 2.32.1
# ruby 3.2.3

rm -Rf /data/home/.local/share/mise/installs/ruby

mise use --global node@24
node -v
# v22.x.x

geany ~/.config/mise/config.toml

echo 'eval "$(~/.local/bin/mise activate bash)"' >>~/.bashrc

mise install

mkdir ~/.config/direnv/lib/
mise direnv activate >~/.config/direnv/lib/use_mise.sh

mise doctor

mise run install
mise run info

mise use -g sops
mise use -g age

mise settings experimental=true
mise lock

exit 0
