#!/bin/bash
set -xv

# See https://www.infracost.io/docs/
curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh
infracost --version
# infracost register
infracost auth login

# infracost diff --path .
infracost breakdown --path .

exit 0
