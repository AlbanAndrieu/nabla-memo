#!/bin/bash
set -xv

# https://github.com/koalaman/shellcheck/wiki/Integration

sudo apt-get install shellcheck
shellcheck -f checkstyle files/*.sh -s bash

./run-go.sh

# See https://docs.gitlab.com/ee/development/shell_scripting_guide/
sudo snap remove shfmt
# as root
go install mvdan.cc/sh/v3/cmd/shfmt@latest
shfmt -i 2 -ci -w files/*.sh

exit 0
