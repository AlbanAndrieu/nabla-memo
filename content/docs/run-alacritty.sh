#!/bin/bash
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
cargo install alacritty
echo "source $(pwd)/extra/completions/alacritty.bash" >> ~/.bashrc
exit 0
