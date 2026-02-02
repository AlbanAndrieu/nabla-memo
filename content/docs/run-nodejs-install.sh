#!/bin/bash
set -xv
sudo apt-get --purge remove node
sudo apt-get --purge remove nodejs
/usr/bin/nodejs --version
/usr/local/bin/node --version
sudo mv /usr/local/bin/node /usr/local/bin/node-TODELETE
sudo rm -rf /usr/local/{lib/node{,/.npm,_modules},bin,share/man}/{npm*,node*,man1/node*}
wget -qO- https://deb.nodesource.com/setup_16.x|  sudo -E bash -
wget -qO- https://deb.nodesource.com/setup_20.x|  sudo -E bash -
wget -qO- https://deb.nodesource.com/setup_22.x|  sudo -E bash -
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg|  sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main"|  sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update&&  sudo apt-get install yarn
sudo apt install -y nodejs
which node
/usr/bin/node --version
/usr/bin/nodejs --version
echo $NODE_PATH
ll /usr/bin/node
sudo npm remove -g node-gyp
sudo npm install -g node-gyp@2.0.2
node-gyp --version
node_modules/node-gyp/bin/node-gyp.js --version
./node/npm/bin/node-gyp-bin/node-gyp --version
node-gyp rebuild
--------------------------------------------------------------------
npm cache clean -f
npm install -g n
n 8.9.4
node -v
/usr/local/bin/node -v
npm cache clear
npm update
npm ls connect
sudo mv /usr/local/bin//npm /usr/local/bin//npm-TODELETE
sudo npm install -g npm@7.11.2
npm whoami
npm adduser
npm login
npm config ls
npm list -g
sudo apt install node-less
sudo apt-get install libcurl4-openssl-dev
npm i pnpm --global
exit 0
