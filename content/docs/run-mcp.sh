#!/bin/bash
sudo apt install python3 python3-pip
pip install "mcp-cli[cli,dev]"
git clone https://github.com/chrishayuk/mcp-cli
cd mcp-cli
pip install -e ".[cli,dev]"
uv sync --reinstall
mcp-cli --version
mcp-cli provider list
mcp-cli provider show
exit 0
