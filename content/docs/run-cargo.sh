#!/bin/bash
set -xv
curl https://sh.rustup.rs -sSf|  sh
rustup self uninstall
echo 'export CARGO_TARGET_DIR=~/cargo-target' >> ~/.bashrc
source ~/.bashrc
rustup update stable
cargo install oxipng --locked
cargo install --list
exit 0
