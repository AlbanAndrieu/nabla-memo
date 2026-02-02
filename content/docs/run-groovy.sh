#!/bin/bash
set -xv
sudo npm install -g npm-groovy-lint@8.2.0
sudo nano /usr/local/lib/node_modules/npm-groovy-lint/lib/groovy-lint.js
"use strict"
ls -lrta .groovylintrc.json
npm-groovy-lint --output json
npm-groovy-lint --format
exit 0
