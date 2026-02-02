#!/bin/bash
set -xv
wget https://github.com/jeremylong/DependencyCheck/releases/download/v7.1.0/dependency-check-7.1.0-release.zip
sudo mv dependency-check-7.1.0-release /opt/
cd /opt
sudo ln -s ./dependency-check-7.1.0-release/dependency-check dependency-check
sudo gem install bundler-audit
bundle-audit update
yarn audit --fix
npm audit --fix
npm audit fix --force
composer install
dependency-check.sh --project "Backend" --out . --scan . --format "ALL"
exit .
