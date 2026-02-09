#!/bin/bash
#set -xv

# Version 9.28.0

npm install --save-dev eslint @eslint/js typescript typescript-eslint eslint-formatter-gitlab

npx eslint
# https://eslint.org/docs/latest/use/getting-started
npm init @eslint/config@latest
npx eslint Gruntfile.js --fix-dry-run
# npx @eslint/migrate-config .eslintrc.json
# npm install @eslint/js @eslint/eslintrc -D
# Run Prettier with --write to fix.
npx eslint .gitlab-ci.yml --fix

npm ci
npx eslint --format gitlab .

npm install @typescript-eslint/parser

exit 0
