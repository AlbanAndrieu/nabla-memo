#!/bin/bash
set -xv

# See https://megalinter.io/6.0.5/

npm install -g npx

./run-eslint.sh

# mega-linter-runner@9.1.0
npx mega-linter-runner@latest --upgrade

npx mega-linter-runner --flavor salesforce -e 'ENABLE=,DOCKERFILE,MARKDOWN,YAML' -e 'SHOW_ELAPSED_TIME=true'
npx mega-linter-runner --flavor python

pre-commit run megalinter-incremental

# https://dotenv-linter.github.io/#/installation
#  curl -sSfL https://raw.githubusercontent.com/dotenv-linter/dotenv-linter/master/install.sh | sh -s
brew install dotenv-linter
dotenv-linter --recursive --exclude ansible

npm i v8r
npx v8r@latest .codeclimate.yml

# as root
curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin
grype ubuntu:latest --fail-on medium
curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sudo sh -s -- -b /usr/local/bin
syft ubuntu:latest

exit 0
