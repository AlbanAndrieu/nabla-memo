#!/bin/bash
set -xv

# See https://github.com/ory/kratos

# If you don't have Ory CLI installed yet:
bash <(curl https://raw.githubusercontent.com/ory/meta/master/install.sh) -b . ory
sudo mv ./ory /usr/local/bin/

exit 0
