#!/bin/bash
set -xv

# See https://jeremylong.github.io/DependencyCheck/dependency-check-cli/index.html

#gpg --keyserver hkp://keys.gnupg.net --recv-keys 259A55407DD6C00299E6607EFFDE55BE73A2D1ED

wget https://github.com/jeremylong/DependencyCheck/releases/download/v7.1.0/dependency-check-7.1.0-release.zip

sudo mv dependency-check-7.1.0-release /opt/
cd /opt
sudo ln -s ./dependency-check-7.1.0-release/dependency-check dependency-check
#source /opt/dependency-check/bin/completion-for-dependency-check.sh

sudo gem install bundler-audit
bundle-audit update

yarn audit --fix
npm audit --fix
npm audit fix --force
composer install
dependency-check.sh --project "Backend" --out . --scan . --format "ALL"

exit .
