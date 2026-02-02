#!/bin/bash
set -xv
echo "Install fd"
sudo apt remove fd-find
wget https://github.com/sharkdp/fd/releases/download/v8.3.1/fd_8.3.1_amd64.deb
sudo dpkg -i fd_8.3.1_amd64.deb
cargo install -f --git https://github.com/jez/as-tree
fd|  as-tree
exit 0
