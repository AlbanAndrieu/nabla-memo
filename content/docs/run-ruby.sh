#!/bin/bash
set -xv

# See https://bundler.io/gemfile.html
sudo apt install ruby-bundler ruby-dev
# sudo apt install ruby-full

# https://operavps.com/docs/install-ruby-on-ubuntu/
# curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
# rbenv install -l
# rbenv install 3.1.5

ruby --version

brew install ruby-install
cd ~/.rubies
# ruby-install ruby 3.0.2
# compas project_base.rb: undefined method `exists?' for File:Class
# Downgrade ruby to less than 3.2
ruby-install ruby 3.1.5
cd ~/.rubies
ll /home/albanandrieu/.rubies/ruby-3.1.5
ln -s ruby-3.1.5 3.1.5

# see https://direnv.net/docs/ruby.html
nano ~/.config/direnv/direnvrc

ruby --version

bundle init
sudo gem update bundler
bundle install --path=vendor/bundle

# gem list

# See https://github.com/guard/guard

bundle
bundle exec guard init

sudo gem install guard-livereload

bundle exec guard

# brew

#brew update --preinstall
#brew bundle dump

ll Brewfile

brew bundle list
brew bundle install
brew bundle exec -- direnv dump

# gem update --system
gem update --system 3.7.2

# For https://github.com/markdownlint/markdownlint
gem install mdl
sudo apt install markdownlint
# coming with  ruby-chef-utils ruby-kramdown ruby-kramdown-parser-gfm ruby-mixlib-cli ruby-mixlib-config ruby-mixlib-shellout ruby-rouge ruby-tomlrb

mdl README.md

# Issue : OpenSSL is not available. Install OpenSSL and rebuild Ruby or use non-HTTPS sources
# Wrong directory
rm -Rf /data/home/.local-TODELETE
rm -Rf /data/home/.cache
mise install

gem install openssl
# Fetching openssl-3.3.2.gem
gem update

gem install github-pages

exit 0
