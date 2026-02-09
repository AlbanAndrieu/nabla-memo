#!/bin/bash
#set -xv

### MCP

sudo apt install python3 python3-pip
# Install MCP CLI
#NOK pip install mcp-cli
pip install "mcp-cli[cli,dev]"

# https://github.com/chrishayuk/mcp-cli?tab=readme-ov-file#install-from-source
git clone https://github.com/chrishayuk/mcp-cli
cd mcp-cli
pip install -e ".[cli,dev]"

uv sync --reinstall

# Install cloud provider plugins
#NOK mcp-cli install aws azure gcp kubernetes

# Verify installation
mcp-cli --version
mcp-cli provider list
mcp-cli provider show

# See https://github.com/chrishayuk/mcp-cli?tab=readme-ov-file#install-from-source

# https://hub.docker.com/mcp
# https://generativeai.pub/model-context-protocol-mcp-10-must-try-mcp-servers-for-developers-4cf054836308

# GitHub MCP
# https://github.com/mcp/io.github.github/github-mcp-server

exit 0
