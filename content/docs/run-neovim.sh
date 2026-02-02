#!/bin/bash
set -xv
sudo add-apt-repository universe
sudo apt install libfuse2
sudo apt install neovim
git clone https://github.com/github/copilot.vim \
  ~/.config/nvim/pack/github/start/copilot.vim
nvim --version
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
exit 0
