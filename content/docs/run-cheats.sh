#!/bin/bash
set -xv

./run-arsenal.sh

curl -s https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh && sudo chmod +x /usr/local/bin/cht.sh

# curl cht.sh/:intro
cht.sh/:intro

exit 0
