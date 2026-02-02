#!/bin/bash
curl -sSf 'https://sh.rustup.rs'|  sh
sudo apt install gcc pkg-config libc6-dev libssl-dev
cargo install lychee
lychee .
exit 0
