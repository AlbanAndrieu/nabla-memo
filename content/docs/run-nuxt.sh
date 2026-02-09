#!/bin/bash
set -xv

# See https://nuxtjs.org/docs/get-started/installation/

yarn create nuxt-app nuxt-project
#? Project name: nuxt-project
#? Programming language: JavaScript
#? Package manager: Yarn
#? UI framework: Tailwind CSS
#? Nuxt.js modules: (Press <space> to select, <a> to toggle all, <i> to invert selection)
#? Linting tools: (Press <space> to select, <a> to toggle all, <i> to invert selection)
#? Testing framework: Jest
#? Rendering mode: Single Page App
#? Deployment target: Server (Node.js hosting)
#? Development tools: (Press <space> to select, <a> to toggle all, <i> to invert selection)
#? Continuous integration: GitHub Actions (GitHub only)
#? What is your GitHub username? albanandrieu
#? Version control system: Git

yarn add --dev @nuxtjs/storybook

yarn add --dev @storybook/testing-library @storybook/jest @storybook/addon-interactions

# * https://storybook.nuxtjs.org/getting-started/installation
# * https://storybook.nuxtjs.org/getting-started/usage/

# npx nuxi@latest devtools enable

npx nuxi@latest cleanup

exit 0
