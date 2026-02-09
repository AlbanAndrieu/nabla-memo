#!/bin/bash
set -xv

npm install -g @mermaid-js/mermaid-cli

mmdc -i simple.mmd -o output.png -t dark -b transparent

mmdc -i README.md -o output.md

# input.mmd
# should look like raw mermaid
# graph TD
#    user(fa:fa-user-circle User) --> pf(PfSense )
#    subgraph "PfSense"

# See https://github.com/mermaid-js/mermaid-cli/issues/730
# for  ./puppeteerConfig.json

# mmdc --puppeteerConfigFile ./puppeteerConfig.json -i input.mmd -o output.png -t dark -b transparent
mmdc --puppeteerConfigFile ./puppeteerConfig.json -i input.mmd -o output-default.png -t default -b transparent

mmdc --puppeteerConfigFile ./puppeteerConfig.json -i input.mmd -o output-after-default.png -t default -b transparent
mmdc --puppeteerConfigFile ./puppeteerConfig.json -i sequence.mmd -o output-sequence-default.png -t default -b transparent

# sudo snap remove slides
# go install github.com/maaslalani/slides@latest
# slides output.md

exit 0
