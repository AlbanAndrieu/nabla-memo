#!/bin/bash
set -xv

# From 30k https://github.com/mathiasbynens/dotfiles

# See https://wiki.archlinux.org/title/XDG_Base_Directory

cd ${HOME}/w/
git clone git@github.com:AlbanAndrieu/dotfiles.git && cd dotfiles && source bootstrap.sh

ln -s ${HOME}/w/dotfiles ${HOME}/dotfiles

# OR
# cd; curl -#L https://github.com/AlbanAndrieu/dotfiles/tarball/main | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh,.osx,LICENSE-MIT.txt}

git clone https://github.com/AlbanAndrieu/bash-it

ln -s ${HOME}/w/bash-it ${HOME}/.bash_it

# https://alex.pearwin.com/2016/02/managing-dotfiles-with-stow/
tree -a ~/dotfiles/ -L 1

exit 0
