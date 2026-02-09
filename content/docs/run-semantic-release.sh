#!/bin/bash
set -xv

# https://semantic-release.gitbook.io/semantic-release/usage/ci-configuration

npx semantic-release

# https://gitlab.com/to-be-continuous/semantic-release/-/tree/master?ref_type=heads
# https://gitlab.com/to-be-continuous/semantic-release/-/blob/master/templates/gitlab-ci-semrel.yml

npm install semantic-release @semantic-release/git @semantic-release/gitlab --save-dev

npm install --save-dev @semantic-release/npm
npm install --save-dev @semantic-release/changelog
npm install --save-dev semantic-release-replace-plugin

npm install -g semantic-release @semantic-release/gitlab
npm install -g semantic-release @semantic-release/changelog

exit 0
