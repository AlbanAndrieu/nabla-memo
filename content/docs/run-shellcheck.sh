#!/bin/bash
set -xv
sudo apt-get install shellcheck
shellcheck -f checkstyle files/*.sh -s bash
./run-go.sh
sudo snap remove shfmt
go install mvdan.cc/sh/v3/cmd/shfmt@latest
shfmt -i 2 -ci -w files/*.sh
exit 0
