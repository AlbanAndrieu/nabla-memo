#!/bin/bash
set -xv

# https://github.com/aaddrick/claude-desktop-debian

sudo apt install icoutils

cd /workspace/users/albandrieu30/jm/github
git clone https://github.com/aaddrick/claude-desktop-debian.git
cd claude-desktop-debian

# Build a .deb package (default)
./build.sh

❌ wrestool not found
❌ icotool not found

sudo apt install ./claude-desktop_0.12.129_amd64.deb

geany ~/.config/Claude/claude_desktop_config.json

tail -f $HOME/claude-desktop-launcher.log

npm install -g @anthropic-ai/claude-code

exit 0
