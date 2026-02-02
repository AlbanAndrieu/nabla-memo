#!/bin/bash
set -xv
pip3 install -U checkov
checkov -d . --download-external-modules true
terraform plan -parallelism=2 -lock=true -out=./plan.tfplan
terraform show -no-color -json plan.tfplan > plan.json
checkov --file plan.json --repo-root-for-plan-enrichment . --download-external-modules "true"
exit 0
