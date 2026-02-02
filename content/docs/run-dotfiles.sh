#!/bin/bash
set -xv
cd $HOME/w/
git clone git@github.com:AlbanAndrieu/dotfiles.git&&  cd dotfiles&&  source bootstrap.sh
ln -s $HOME/w/dotfiles   $HOME/dotfiles
git clone https://github.com/AlbanAndrieu/bash-it
ln -s $HOME/w/bash-it   $HOME/.bash_it
tree -a ~/dotfiles/ -L 1
exit 0
