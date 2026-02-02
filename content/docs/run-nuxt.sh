#!/bin/bash
set -xv
yarn create nuxt-app nuxt-project
yarn add --dev @nuxtjs/storybook
yarn add --dev @storybook/testing-library @storybook/jest @storybook/addon-interactions
npx nuxi@latest cleanup
exit 0
