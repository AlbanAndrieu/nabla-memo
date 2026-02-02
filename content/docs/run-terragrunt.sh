#!/bin/bash
set -xv
asdf plugin add terragrunt
asdf install terragrunt latest
asdf set --home terragrunt latest
terragrunt --version
exit 0
