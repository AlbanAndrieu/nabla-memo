#!/bin/bash
set -xv
cd /home/albandrieu/w/follow/
git clone git@github.com:hashicorp/damon.git
cd /home/albandrieu/w/follow/damon
make build
make run
damon
exit 0
