#!/bin/bash
set -xv
curl --compressed -o- -L https://yarnpkg.com/install.sh|  bash
yarn set version berry
npm install -g create-react-app@latest
npm install react-scripts
npm install cra-template
yarn --version
npx create-react-app nabla-site-react
npm install -g corepack
corepack enable
exit 0
