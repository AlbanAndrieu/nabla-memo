#!/bin/bash
set -xv

# https://github.com/neovim/neovim/wiki/Installing-Neovim

sudo add-apt-repository universe
sudo apt install libfuse2

sudo apt install neovim

# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
# chmod u+x nvim.appimage
# ./nvim.appimage

# https://docs.github.com/en/copilot/getting-started-with-github-copilot/getting-started-with-github-copilot-in-neovim

git clone https://github.com/github/copilot.vim \
  ~/.config/nvim/pack/github/start/copilot.vim

nvim --version

# :Copilot setup
# :Copilot enable

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

exit 0
