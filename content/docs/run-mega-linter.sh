#!/bin/bash
set -xv
npm install -g npx
./run-eslint.sh
npx mega-linter-runner@latest --upgrade
npx mega-linter-runner --flavor salesforce -e 'ENABLE=,DOCKERFILE,MARKDOWN,YAML' -e 'SHOW_ELAPSED_TIME=true'
npx mega-linter-runner --flavor python
pre-commit run megalinter-incremental
brew install dotenv-linter
dotenv-linter --recursive --exclude ansible
npm i v8r
npx v8r@latest .codeclimate.yml
curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh|  sh -s -- -b /usr/local/bin
grype ubuntu:latest --fail-on medium
curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh|  sudo sh -s -- -b /usr/local/bin
syft ubuntu:latest
exit 0
