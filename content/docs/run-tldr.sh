#!/bin/bash
set -xv

echo "Install tldr"

# See https://blog.stephane-robert.info/docs/outils/indispensables/

# sudo snap install tldr
# sudo npm install -g tldr
pipx install tldr

tldr --update

tldr -l

exit 0
