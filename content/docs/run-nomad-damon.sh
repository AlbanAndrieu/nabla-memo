#!/bin/bash
set -xv

# See https://github.com/hashicorp/damon
cd /home/albandrieu/w/follow/
git clone git@github.com:hashicorp/damon.git
cd /home/albandrieu/w/follow/damon
make build
make run
#go install ./cmd/damon
damon

exit 0
