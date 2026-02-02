#!/bin/bash
set -xv
sudo apt install ruby-bundler ruby-dev
ruby --version
brew install ruby-install
cd ~/.rubies
ruby-install ruby 3.1.5
cd ~/.rubies
ll /home/albanandrieu/.rubies/ruby-3.1.5
ln -s ruby-3.1.5 3.1.5
nano ~/.config/direnv/direnvrc
ruby --version
bundle init
sudo gem update bundler
bundle install --path=vendor/bundle
bundle
bundle exec guard init
sudo gem install guard-livereload
bundle exec guard
ll Brewfile
brew bundle list
brew bundle install
brew bundle exec -- direnv dump
gem update --system 3.7.2
gem install mdl
sudo apt install markdownlint
mdl README.md
rm -Rf /data/home/.local-TODELETE
rm -Rf /data/home/.cache
mise install
gem install openssl
gem update
gem install github-pages
exit 0
