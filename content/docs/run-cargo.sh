#!/bin/bash
set -xv

# https://doc.rust-lang.org/cargo/getting-started/installation.html

curl https://sh.rustup.rs -sSf | sh
rustup self uninstall

# https://stackoverflow.com/questions/78998149/to-reuse-those-artifacts-with-a-future-compilation-set-the-environment-variable
echo 'export CARGO_TARGET_DIR=~/cargo-target' >>~/.bashrc
source ~/.bashrc

rustup update stable

cargo install oxipng --locked

cargo install --list

exit 0
