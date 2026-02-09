#!/bin/bash
set -xv

# See https://github.com/nvm-sh/nvm

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

nvm ls-remote --lts
nvm --version
nvm version

#nvm install 14
nvm install 24.11.0
nvm install 20.19.1
nvm install --lts
nvm alias default 20.19.1
#nvm use 16

rm -Rf /etc/profile.d/npm.sh
#npm config delete prefix
#npm config set prefix $NVM_DIR/versions/node/v6.11.1

node -v

exit 0
