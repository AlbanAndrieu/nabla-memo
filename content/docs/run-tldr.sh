#!/bin/bash
set -xv
echo "Install tldr"
pipx install tldr
tldr --update
tldr -l
exit 0
