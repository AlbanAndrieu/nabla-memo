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

npm i mcp-remote

ll ~/.cursor/mcp.json
# with a copy in /workspace/users/albandrieu30/nabla/env/home/.cursor

# AWSOME MCP : https://github.com/punkpeye/awesome-mcp-servers?tab=readme-ov-file

# See https://github.com/chrishayuk/mcp-cli?tab=readme-ov-file#install-from-source

# https://hub.docker.com/mcp
# https://generativeai.pub/model-context-protocol-mcp-10-must-try-mcp-servers-for-developers-4cf054836308

# GitHub MCP
# https://github.com/mcp/io.github.github/github-mcp-server

# Notion MCP
# https://github.com/mcp/makenotion/notion-mcp-server

# AWS MCP
# https://github.com/awslabs/mcp?tab=readme-ov-file
# https://github.com/awslabs/mcp/tree/main/src/eks-mcp-server

START=$(date +%Y-%m-01); END=$(date +%Y-%m-%d); aws ce get-cost-and-usage --time-period Start="$START",End="$END" --granularity MONTHLY --metrics BlendedCost UnblendedCost --group-by Type=DIMENSION,Key=SERVICE 2>&1
aws ce get-cost-and-usage \
     --time-period Start=2025-02-01,End=2025-02-12 \
     --granularity MONTHLY \
     --metrics BlendedCost UnblendedCost

# K8S
# https://github.com/Flux159/mcp-server-kubernetes
npx mcp-chat --server "npx mcp-server-kubernetes"

# GRAFANA
# https://github.com/grafana/mcp-grafana

exit 0
