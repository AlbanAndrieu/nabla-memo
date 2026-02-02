#!/bin/bash
set -xv
chmod u=rwx,go= ~/.ssh
chmod 600 ~/.ssh/config
ssh-keygen -t ed25519 -C "a.andrieu@jusmundi.com"
ssh-add ~/.ssh/aandrieu_ed25519
sudo chmod 400 ~/.ssh/*ed25519*
ssh -T git@github.com
export GIT_TRACE=true
export GIT_CURL_VERBOSE=true
export GIT_SSH_COMMAND="ssh -vvv"
ssh -Tv git@gitlab.com
ssh-keygen -t ecdsa-sk -C "alban.andrieu@free.fr"
ll /home/albanandrieu/.ssh/id_ecdsa_sk
ssh-keygen -t rsa -b 4096
chmod 400 ~/.ssh/id_rsa*
chmod 400 ~/.ssh/nabla/id_rsa*
ssh-keygen -y
ssh -T git-codecommit.us-east-2.amazonaws.com
ssh-add -t 3h42 ~/.ssh/id_ed25519
ssh-add -D
ssh-add ~/.ssh/id_ed25519
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/nabla/id_rsa
ssh-add ~/.ssh/service_terraform
ssh-add ~/.ssh/terraform_rsa
ssh-add ~/.ssh/id_ecdsa_sk
ssh-add -k ~/.ssh/id_ed25519
ssh-add -l
ssh-add -L
ssh-keygen -l -f id_rsa.pub
exit 0
