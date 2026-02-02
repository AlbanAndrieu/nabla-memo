#!/bin/bash
wget -q https://raw.githubusercontent.com/dapr/cli/master/install/install.sh -O -|  /bin/bash
sudo dapr init
dapr --version
ls $HOME/.dapr
dapr run --app-id myapp --dapr-http-port 3500
exit 0
