#!/bin/bash
set -xv

echo "Install rust"

# See https://www.rust-lang.org/fr/learn/get-started

# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

sudo apt install rustup
# rustup self update
# rustup update stable
rustup install nightly

rustc --version
# sudo apt install rustc

# Use nightly
# https://shape.host/resources/installer-et-configurer-rust-sur-ubuntu-22-04-un-guide-complet
rustup toolchain install nightly
rustup update

mkdir -p ~/.local/share/bash-completion/completions/
rustup completions bash >~/.local/share/bash-completion/completions/rustup
source ~/.local/share/bash-completion/completions/rustup

rustup toolchain list
rustup toolchain install nightly
rustup default nightly
# rustup override set nightly

rustc -Vv
rustup show profile

# supprimer
rm -rf ~/.cargo
rm -rf ~/.rustup
rm -f ~/.local/share/bash-completion/completions/rustup

sudo apt install cargo

# debug
rustup component add rust-analyzer
sudo apt install gdb lldb

exit 0
