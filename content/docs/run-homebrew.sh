#!/bin/bash
set -xv

#See http://linuxbrew.sh/

sudo apt-get install build-essential curl file git ruby # python-setuptools
#sudo yum install curl file git irb python-setuptools ruby
./run-ruby.sh

#sudo apt-get install linuxbrew-wrapper

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#PATH="$HOME/.linuxbrew/bin:$PATH"
#echo 'export PATH="$HOME/.linuxbrew/bin:$PATH"' >>~/.bash_profile

echo 'export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"' >>~/.bash_profile

brew --version
brew doctor

#ansible installed by brew
rm -Rf /home/linuxbrew/.linuxbrew/bin/ansible*

brew update && brew upgrade
brew cleanup

brew tap --repair

#brew uninstall python3 glib cairo
brew uninstall python@3.9 glib cairo

ll Brewfile.lock.json

brew install randomize-lines # For git-radar
brew install michaeldfallen/formula/git-radar
brew install up
brew install navi
brew install terraform_landscape

exit 0
