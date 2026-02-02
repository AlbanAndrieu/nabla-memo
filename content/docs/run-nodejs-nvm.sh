#!/bin/bash
set -xv
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh|  bash
nvm ls-remote --lts
nvm --version
nvm version
nvm install 24.11.0
nvm install 20.19.1
nvm install --lts
nvm alias default 20.19.1
rm -Rf /etc/profile.d/npm.sh
node -v
exit 0
