#!/bin/bash
set -xv
echo "Install exa"
sudo apt install eza
exa /etc -lhgi
sudo wget https://raw.githubusercontent.com/ogham/exa/master/completions/bash/exa -O /etc/bash_completion.d/exa.bash
alias l='exa'
alias la='exa -a'
alias ll='exa -lahg'
alias ls='exa --color=auto'
exit 0
