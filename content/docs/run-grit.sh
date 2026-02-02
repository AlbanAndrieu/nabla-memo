#!/bin/bash
set -xv
curl -fsSL https://docs.grit.io/install|  bash
grit init
ll /workspace/users/albandrieu30/jm/infra/tf-jusmundi/.grit/grit.yaml
grit apply github.com/cloudflare/terraform-provider-cloudflare#cloudflare_terraform_v5
grit list
exit 0
