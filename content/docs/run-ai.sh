#!/bin/bash
#set -xv

# See https://medium.com/@osomudeyazudonu/the-ai-toolkit-that-made-me-a-10x-devops-engineer-without-burnout-or-buzzwords-beef70279ff1

### AWS

#### AWS Q Developer CLI
# Windows (using installer from aws.amazon.com/cli)
# Download and run the MSI installer

# macOS
brew install awscli

# Linux/WSL
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

#### Enable Q Developer features:
# Install the Q Developer plugin

# https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line-installing.html
wget https://desktop-release.q.us-east-1.amazonaws.com/latest/amazon-q.appimage
chmod +x amazon-q.appimage

# NOK pip install awscli-plugin-q
wget https://desktop-release.q.us-east-1.amazonaws.com/latest/amazon-q.deb
sudo apt-get install -f
sudo dpkg -i amazon-q.deb

aws q

# https://github.com/awslabs/mcp
geany ~/.aws/amazonq/mcp.json

# sudo apt-get purge amazon-q

# Configure AWS CLI with your credentials
aws configure

# Enable Q Developer
aws configure set plugins.cli_dev_tools awscli_plugin_q

#### Test AWS Q:

# Test basic functionality
aws q "list my EC2 instances"

# Test with a file
echo "AWSTemplateFormatVersion: '2010-09-09'" >test.yaml
aws q "explain this CloudFormation template" --file test.yaml

# https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html
/usr/local/bin/sam --version

### AZURE

# brew install azure-cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install AI-related extensions
az extension add --name ai-examples
az extension add --name ml

# Login to Azure
az login

./run-azure.sh

# Set your default subscription
az account set --subscription "d0c9b27d-2d5e-47cd-8589-bf26727a7d1f"

# Test basic AI functionality
az ai explain "what is Azure Container Instances"

# Test with infrastructure
echo '{"$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"}' >test.json
az ai analyze --file test.json --type arm-template

### GCP

# Windows
# Download installer from cloud.google.com/sdk/docs/install

# macOS
brew install google-cloud-sdk

# Linux/WSL
curl https://sdk.cloud.google.com | bash
exec -l $SHELL

# Initialize gcloud
./run-gcloud.sh

# See https://github.com/openai/codex

npm install -g @openai/codex
codex

# See https://github.com/github/copilot-cli?locale=en-US
npm install -g @github/copilot
copilot

# https://leonardomontini.dev/copilot-cli-vs-warp-ai/
npm install -g @githubnext/github-copilot-cli
sudo chmod 644 /etc/apt/sources.list.d/github-cli.list
github-copilot-cli auth


# lumen
brew install jnsahaj/lumen/lumen

# Useful tool to compute a model’s weights memory nee
# https://huggingface.co/spaces/hf-accelerate/model-memory-usage

# Useful tool to compute a model’s KV cache memory need
# https://huggingface.co/spaces/HathoraResearch/LLM-KV-cache-calculator

# https://github.com/google-gemini/gemini-cli
npm install -g @google/gemini-cli

exit 0
