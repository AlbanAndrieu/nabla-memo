#!/bin/bash
set -xv

# https://blog.stephane-robert.info/docs/outils/systeme/asdf-vm/

# sudo rm -Rf /home/albanandrieu/.asdf
# sudo rm -Rf /home/albandrieu/.asdf
# git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
brew install asdf
brew --prefix asdf

asdf --version

asdf plugin-add python
asdf list all python | grep "^3.*"

# asdf update # Upgrading asdf via asdf update

asdf plugin-add direnv

asdf latest --all

# plugins
asdf plugin list all
asdf plugin update --all

# https://blog.stephane-robert.info/docs/outils/fichiers/ripgrep/

asdf plugin add ripgrep
asdf install ripgrep latest
asdf global ripgrep latest
rg --version

which rg
rg -C 3 'error' nabla/
rg -C 3 'openstack' .

asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby 3.1.5
asdf install ruby 3.4.7

# https://blog.stephane-robert.info/docs/conteneurs/moteurs-conteneurs/lazydocker/

asdf plugin add lazydocker https://github.com/comdotlinux/asdf-lazydocker.git
asdf install lazydocker latest
asdf global lazydocker latest
lazydocker --version

asdf list all lazydocker
ll ~/.config/lazydocker/config.yml
echo "alias lzd='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v /home/albanandrieu/.config/:/.config/jesseduffield/lazydocker lazyteam/lazydocker'" >>~/.bashrc

asdf plugin add terragrunt
asdf install terragrunt latest
asdf set --home terragrunt latest

asdf plugin add mkcert https://github.com/salasrod/asdf-mkcert.git
asdf install mkcert latest
asdf set --home mkcert latest

# Fix bug https://github.com/jesseduffield/lazydocker/issues/493
# remove - "currentContext": "default" from ~/.docker/config.json

# Issue : You have tried to upgrade to asdf 0.16.0 or newer
# See https://asdf-vm.com/guide/upgrading-to-v0-16
asdf reshim

which gem
# is ok /home/albanandrieu/.asdf/shims/gem

exit 0
