#!/bin/bash
set -xv
brew install asdf
brew --prefix asdf
asdf --version
asdf plugin-add python
asdf list all python|  grep "^3.*"
asdf plugin-add direnv
asdf latest --all
asdf plugin list all
asdf plugin update --all
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
asdf plugin add lazydocker https://github.com/comdotlinux/asdf-lazydocker.git
asdf install lazydocker latest
asdf global lazydocker latest
lazydocker --version
asdf list all lazydocker
ll ~/.config/lazydocker/config.yml
echo "alias lzd='docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v /home/albanandrieu/.config/:/.config/jesseduffield/lazydocker lazyteam/lazydocker'" >> ~/.bashrc
asdf plugin add terragrunt
asdf install terragrunt latest
asdf set --home terragrunt latest
asdf plugin add mkcert https://github.com/salasrod/asdf-mkcert.git
asdf install mkcert latest
asdf set --home mkcert latest
asdf reshim
which gem
exit 0
