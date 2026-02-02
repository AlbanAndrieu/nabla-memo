#!/bin/bash
set -xv

# Vue 2
##npm init vue@2 -save
npm init vue@2
##cd -save/
#cd vue-project/
#npm install
#npm run lint
#npm run dev

# https://storybook.js.org/tutorials/intro-to-storybook/vue/en/get-started/

npx v8r@latest .mega-linter.yml
npx storybook init

#install linux wsl2 :
sudo apt install nodejs
#clone du nuxt JM : git clone https://gitlab.com/jusmundi-group/web/nuxt
yarn install
yarn storybook
addon interactions

#Install testing :

yarn add --dev @storybook/test-runner jest@27
{
  "scripts": {
    "test-storybook": "test-storybook"
  }
}

yarn storybook

#Finally, open a new terminal window and run the test-runner with:
yarn test-storybook --watch
#By default, the test-runner assumes that you re running it against a locally served Storybook on port 6006
#https://storybook.js.org/docs/vue/writing-tests/interaction-testing
yarn add --dev @storybook/testing-library @storybook/jest @storybook/addon-interactions

# See https://devtools.vuejs.org/guide/installation.html

exit 0
