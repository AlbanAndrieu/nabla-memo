#!/bin/bash
set -xv
sudo apt-get install build-essential curl file git ruby
./run-ruby.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"' >> ~/.bash_profile
brew --version
brew doctor
rm -Rf /home/linuxbrew/.linuxbrew/bin/ansible*
brew update&&  brew upgrade
brew cleanup
brew tap --repair
brew uninstall python@3.9 glib cairo
ll Brewfile.lock.json
brew install randomize-lines
brew install michaeldfallen/formula/git-radar
brew install up
brew install navi
brew install terraform_landscape
exit 0
