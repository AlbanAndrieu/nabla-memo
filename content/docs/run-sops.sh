#!/bin/bash
#set -xv

# https://blog.stephane-robert.info/docs/securiser/secrets/sops/

mise use sops

sudo apt install age

mkdir -p ~/keys
age-keygen -o ~/keys/nabla-age-ley.txt
# Public key: ${AGE_PUBLIC_KEY_NABLA}

cp ~/keys/nabla-age-ley.txt ~/.config/mise/age.txt

sops -e --age=${AGE_PUBLIC_KEY_NABLA} test.yaml > test-enc.yaml

export AWS_PROFILE=eks
export AWS_DEFAULT_REGION=us-east-1

aws kms create-key --tags TagKey=Purpose,TagValue=Test --description "My first KMS key"

sops -e --kms ${AWS_KMS_JM} test.yaml > test-enc.yml
sops -e --kms ${AWS_KMS_JM} --age=${AGE_PUBLIC_KEY_NABLA} test.yaml > test-enc.yaml
sops -e --kms ${AWS_KMS_JM} --age=${AGE_PUBLIC_KEY_NABLA} secrets.yaml > secrets-enc.yaml

sops -d test-enc.yaml

# export SOPS_AGE_KEY_FILE=~/keys/ma-second-cle-age.txt
# SOPS_AGE_KEY_FILE=~/.config/mise/age.txt

mise env --redacted --values

sops --hc-vault-transit $VAULT_ADDR/v1/sops/keys/my-encryption-key --encrypt \
--encrypted-regex '^(data|stringData)$' --in-place basic-auth.yaml

exit 0
