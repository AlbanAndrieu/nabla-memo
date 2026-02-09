#!/bin/bash
set -xv

# https://yarnpkg.com/getting-started/install
# upgrade yarn
curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

# yarn set version latest
# sudo yarn set version stable
yarn set version berry

# sudo npm install -g yarn

npm install -g create-react-app@latest
npm install react-scripts
npm install cra-template

yarn --version

npx create-react-app nabla-site-react

#ext install dsznajder.es7-react-js-snippets

npm install -g corepack
corepack enable

exit 0
