#!/bin/bash
sudo apt-get install -y powershell
curl -sL https://aka.ms/InstallAzureCLIDeb|  sudo bash
export AZURE_DNS_SUBSCRIPTION=${AZURE_DNS_SUBSCRIPTION:="DEV-C20-001"}
export AZURE_DNS_RSC_GROUP=${AZURE_DNS_RSC_GROUP:="AZR-C21-DV-505-01"}
az login
az account list --output table
az account show
az account get-access-token
az account set --subscription "DEV-C20-001"
az group list --output table
az resource list
az --version
az login
az login --tenant "e17e2402-2a40-42ce-ad75-5848b8d4f6b6"
az login --use-device-code
az login --identity
az login --tenant "e17e2402-2a40-42ce-ad75-5848b8d4f6b6"
az account set --subscription "DEV-C20-001"
az acr login --name p21d13401013001
az acr login --name p21d13401013001 --username $SP_APP_ID --password $SP_PASSWD
az identity show --resource-group AZR-C21-DV-322-01 --name p21d13401013001
az acr show --name p21d50501532001 --query id --output tsv
docker login p21d13401013001.azurecr.io --username $SP_APP_ID --password $SP_PASSWD
docker pull p21d13401013001.azurecr.io/fusion-risk/ansible-jenkins-slave
docker pull p21d13401013001.azurecr.io/fusion-risk/jenkins-pipeline-scripts:1.0.1
sudo microk8s ctr --debug images pull p21d13401013001.azurecr.io/fusion-risk/bower-fr-integration-test:latest
az acr check-health -n p21d13401013001 --yes
az acr list --output table
az provider operation show --namespace Microsoft.ContainerRegistry
az acr repository show-manifests -n p21d13401013001 --repository fusion-risk/ansible-jenkins-slave --orderby time_desc
az acr repository list --name p21d13401013001 --output table
az account set --subscription DEV-C20-001
az aks get-credentials --name p21d50501533001 --resource-group AZR-C21-DV-505-01
sudo az aks install-cli
kubectl version --client
aadgname=todo
az ad group list --filter "displayname eq '$aadgname'" -O table
az aks get-credentials -g AKS-Demo -n aksdemocluster
az aks list
k get no
wget https://raw.githubusercontent.com/ansible-collections/community.general/main/scripts/inventory/azure_rm.py
chmod +x ./azure_rm.py
./azure_rm.py --help
nano $HOME/.azure/credentials
ansible -i azure_rm.py Testing -m shell -a "/bin/uname -a"
exit 0
