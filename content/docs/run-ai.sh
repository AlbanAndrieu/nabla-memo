#!/bin/bash
brew install awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
wget https://desktop-release.q.us-east-1.amazonaws.com/latest/amazon-q.appimage
chmod +x amazon-q.appimage
wget https://desktop-release.q.us-east-1.amazonaws.com/latest/amazon-q.deb
sudo apt-get install -f
sudo dpkg -i amazon-q.deb
aws q
geany ~/.aws/amazonq/mcp.json
aws configure
aws configure set plugins.cli_dev_tools awscli_plugin_q
aws q "list my EC2 instances"
echo "AWSTemplateFormatVersion: '2010-09-09'" > test.yaml
aws q "explain this CloudFormation template" --file test.yaml
/usr/local/bin/sam --version
curl -sL https://aka.ms/InstallAzureCLIDeb|  sudo bash
az extension add --name ai-examples
az extension add --name ml
az login
./run-azure.sh
az account set --subscription "d0c9b27d-2d5e-47cd-8589-bf26727a7d1f"
az ai explain "what is Azure Container Instances"
echo '{"$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"}' > test.json
az ai analyze --file test.json --type arm-template
brew install google-cloud-sdk
curl https://sdk.cloud.google.com|  bash
exec -l $SHELL
gcloud init
gcloud auth login
gcloud components install alpha beta
gcloud services enable aiplatform.googleapis.com
export PROJECT_ID="1054538550931"
gcloud config set project PROJECT_ID
gcloud version
npm install -g @openai/codex
codex
npm install -g @github/copilot
copilot
npm install -g @githubnext/github-copilot-cli
sudo chmod 644 /etc/apt/sources.list.d/github-cli.list
github-copilot-cli auth
brew install jnsahaj/lumen/lumen
npm install -g @google/gemini-cli
exit 0
