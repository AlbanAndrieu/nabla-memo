#!/bin/bash
set -xv

# https://blog.stephane-robert.info/docs/infra-as-code/provisionnement/terragrunt/

# brew install terragrunt
# or
asdf plugin add terragrunt
asdf install terragrunt latest
asdf set --home terragrunt latest

terragrunt --version
# terragrunt version v0.93.9

exit 0
