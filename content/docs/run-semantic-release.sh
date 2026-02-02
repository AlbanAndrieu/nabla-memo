#!/bin/bash
set -xv
npx semantic-release
npm install semantic-release @semantic-release/git @semantic-release/gitlab --save-dev
npm install --save-dev @semantic-release/npm
npm install --save-dev @semantic-release/changelog
npm install --save-dev semantic-release-replace-plugin
npm install -g semantic-release @semantic-release/gitlab
npm install -g semantic-release @semantic-release/changelog
exit 0
