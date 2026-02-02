#!/bin/bash
set -xv
./run-gpg.sh
sudo apt-get install rng-tools -y
sudo rngd -r /dev/urandom
sudo apt-get install pass -y
gpg --list-secret-keys
sudo apt install golang-docker-credential-helpers
docker-credential-pass list
ll .password-store/
pass insert docker-credential-helpers/docker-pass-initialized-check
pass ls
pass insert docker-credential-pass/docker-pass-initialized-check
exit 0
