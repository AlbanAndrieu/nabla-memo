#!/bin/bash
set -xv

npm install -g prettier

prettier --write .

exit 0
