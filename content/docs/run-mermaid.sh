#!/bin/bash
set -xv
npm install -g @mermaid-js/mermaid-cli
mmdc -i simple.mmd -o output.png -t dark -b transparent
mmdc -i README.md -o output.md
mmdc --puppeteerConfigFile ./puppeteerConfig.json -i input.mmd -o output-default.png -t default -b transparent
mmdc --puppeteerConfigFile ./puppeteerConfig.json -i input.mmd -o output-after-default.png -t default -b transparent
mmdc --puppeteerConfigFile ./puppeteerConfig.json -i sequence.mmd -o output-sequence-default.png -t default -b transparent
exit 0
