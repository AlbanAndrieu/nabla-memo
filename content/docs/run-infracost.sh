#!/bin/bash
set -xv
curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh|  sh
infracost --version
infracost auth login
infracost breakdown --path .
exit 0
