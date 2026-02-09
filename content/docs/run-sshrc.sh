#!/bin/bash
set -xv

# https://korben.info/sshrc-dotfiles-ssh-server.html

brew install sshrc

# NOK sudo add-apt-repository ppa:russell-s-stewart/ppa
# NOK sudo apt-get update
# NOK sudo apt-get install sshrc

# NOK wget https://raw.githubusercontent.com/Russell91/sshrc/master/sshrc &&
# NOK chmod +x sshrc &&
# NOK sudo mv sshrc /usr/local/bin #or anywhere else on your PATH

cho "echo welcome" >>~/.sshrc

nano ~/.sshrc
# export VIMINIT="let \$MYVIMRC='$SSHHOME/.sshrc.d/.vimrc' | source \$MYVIMRC"

sshrc user@server

exit 1
