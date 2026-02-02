#!/bin/bash
set -xv
sudo apt-get install gcovr
sudo apt-get install subversion git cmake lcov libssl-dev
brew update
brew install FORMULA
brew install file-formula
brew install https://github.com/oclint/oclint/releases/download/v0.12/oclint-0.12-x86_64-linux-4.4.0-66-generic.tar.gz
brew upgrade oclint
brew install xctool
brew untap michaeldfallen/formula
exit 0
