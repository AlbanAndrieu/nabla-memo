#!/bin/bash
set -xv
echo "Install rust"
sudo apt install rustup
rustup install nightly
rustc --version
rustup toolchain install nightly
rustup update
mkdir -p ~/.local/share/bash-completion/completions/
rustup completions bash > ~/.local/share/bash-completion/completions/rustup
source ~/.local/share/bash-completion/completions/rustup
rustup toolchain list
rustup toolchain install nightly
rustup default nightly
rustc -Vv
rustup show profile
rm -rf ~/.cargo
rm -rf ~/.rustup
rm -f ~/.local/share/bash-completion/completions/rustup
sudo apt install cargo
rustup component add rust-analyzer
sudo apt install gdb lldb
exit 0
