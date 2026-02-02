#!/bin/bash
set -xv
cd ~
git clone https://github.com/klen/.vim.git ~/.vim
cd ~/.vim&&  git submodule init&&  git submodule update
exit 0
