#!/bin/bash
#set -xv

# See https://docs.dapr.io/getting-started/

wget -q https://raw.githubusercontent.com/dapr/cli/master/install/install.sh -O - | /bin/bash

sudo dapr init
#dapr init --kubernetes

dapr --version

ls $HOME/.dapr

#dapr run
dapr run --app-id myapp --dapr-http-port 3500

exit 0
