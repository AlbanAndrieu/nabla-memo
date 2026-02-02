#!/bin/bash
npm install --save-dev eslint @eslint/js typescript typescript-eslint eslint-formatter-gitlab
npx eslint
npm init @eslint/config@latest
npx eslint Gruntfile.js --fix-dry-run
npx eslint .gitlab-ci.yml --fix
npm ci
npx eslint --format gitlab .
npm install @typescript-eslint/parser
exit 0
