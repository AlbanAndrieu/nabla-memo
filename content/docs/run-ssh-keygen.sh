#!/bin/bash
set -xv

chmod u=rwx,go= ~/.ssh
chmod 600 ~/.ssh/config

# See https://www.unixtutorial.org/how-to-generate-ed25519-ssh-key/
#ssh-keygen -f ~/test-key-rsa -t rsa -b 4096

ssh-keygen -t ed25519 -C "a.andrieu@jusmundi.com"
ssh-add ~/.ssh/aandrieu_ed25519
sudo chmod 400 ~/.ssh/*ed25519*
ssh -T git@github.com
export GIT_TRACE=true
export GIT_CURL_VERBOSE=true
export GIT_SSH_COMMAND="ssh -vvv"
ssh -Tv git@gitlab.com

# Generate key for yubikey
ssh-keygen -t ecdsa-sk -C "alban.andrieu@free.fr"
# -O resident -O verify-required
# No passphrase
ll /home/albanandrieu/.ssh/id_ecdsa_sk

#ssh-keygen -t ed25519 -C "c.nicholls@jusmundi.com"

ssh-keygen -t rsa -b 4096
#Permissions for '.ssh/id_rsa' are too open
chmod 400 ~/.ssh/id_rsa*
chmod 400 ~/.ssh/nabla/id_rsa*
# check passphrase
ssh-keygen -y
ssh -T git-codecommit.us-east-2.amazonaws.com

# Setting up a maximum lifetime for identities/private keys
ssh-add -t 3h42 ~/.ssh/id_ed25519 # 3 hours 42 minutes

# Remove keys
ssh-add -D
# with passphrase
ssh-add ~/.ssh/id_ed25519
ssh-add ~/.ssh/id_rsa
# without passphrase
ssh-add ~/.ssh/nabla/id_rsa
ssh-add ~/.ssh/service_terraform
ssh-add ~/.ssh/terraform_rsa
ssh-add ~/.ssh/id_ecdsa_sk # the yubikey

ssh-add -k ~/.ssh/id_ed25519
#ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# list your key
ssh-add -l
ssh-add -L

# check RSA bits
ssh-keygen -l -f id_rsa.pub

exit 0
