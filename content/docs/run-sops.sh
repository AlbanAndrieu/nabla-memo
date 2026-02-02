#!/bin/bash
mise use sops
sudo apt install age
mkdir -p ~/keys
age-keygen -o ~/keys/nabla-age-ley.txt
cp ~/keys/nabla-age-ley.txt ~/.config/mise/age.txt
sops -e --age=$AGE_PUBLIC_KEY_NABLA   test.yaml > test-enc.yaml
export AWS_PROFILE=eks
export AWS_DEFAULT_REGION=us-east-1
aws kms create-key --tags TagKey=Purpose,TagValue=Test --description "My first KMS key"
sops -e --kms $AWS_KMS_JM   test.yaml > test-enc.yml
sops -e --kms $AWS_KMS_JM   --age=$AGE_PUBLIC_KEY_NABLA   test.yaml > test-enc.yaml
sops -e --kms $AWS_KMS_JM   --age=$AGE_PUBLIC_KEY_NABLA   secrets.yaml > secrets-enc.yaml
sops -d test-enc.yaml
mise env --redacted --values
exit 0
