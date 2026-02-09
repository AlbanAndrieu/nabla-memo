#!/bin/bash
set -xv

echo "Install exa"

# See https://lindevs.com/install-exa-on-ubuntu/

# EXA_VERSION=$(curl -s "https://api.github.com/repos/ogham/exa/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
# echo $EXA_VERSION
# #0.10.1
# curl -Lo exa.zip "https://github.com/ogham/exa/releases/latest/download/exa-linux-x86_64-v${EXA_VERSION}.zip"
# sudo unzip -q exa.zip bin/exa -d /usr/local
# exa --version
# rm -rf exa.zip

sudo apt install eza

exa /etc -lhgi

# bash completion
sudo wget https://raw.githubusercontent.com/ogham/exa/master/completions/bash/exa -O /etc/bash_completion.d/exa.bash

alias l='exa'
alias la='exa -a'
alias ll='exa -lahg'
alias ls='exa --color=auto'

exit 0
