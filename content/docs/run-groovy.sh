#!/bin/bash
set -xv

#See https://www.npmjs.com/package/npm-groovy-lint
# For vscode

sudo npm install -g npm-groovy-lint@8.2.0
#npm install -g npm-groovy-lint@7.6.4
#npm install -g npm-groovy-lint@5.8.0

# See https://stackoverflow.com/questions/34353512/node-npm-package-throw-use-strict-command-not-found-after-publish-and-install-g
#  use strict is supposed to be at the very top of file:
sudo nano /usr/local/lib/node_modules/npm-groovy-lint/lib/groovy-lint.js
#!/usr/bin/env node
"use strict"

ls -lrta .groovylintrc.json

npm-groovy-lint --output json
npm-groovy-lint --format

#code --install-extension NicolasVuillamy.vscode-groovy-lint

exit 0
