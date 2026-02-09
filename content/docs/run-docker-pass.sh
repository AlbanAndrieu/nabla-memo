#!/bin/bash
set -xv

# See https://docs.docker.com/engine/reference/commandline/login/#credentials-store
# See https://www.passwordstore.org/

./run-gpg.sh

# See http://tuxlabs.com/?p=450

# See https://thenewstack.io/how-to-enable-docker-experimental-features-and-encrypt-your-login-credentials/
sudo apt-get install rng-tools -y
sudo rngd -r /dev/urandom
sudo apt-get install pass -y
#gpg --full-generate-key
gpg --list-secret-keys

sudo apt install golang-docker-credential-helpers
docker-credential-pass list

ll .password-store/

# https://github.com/docker/docker-credential-helpers/issues/140
pass insert docker-credential-helpers/docker-pass-initialized-check
pass ls
pass insert docker-credential-pass/docker-pass-initialized-check

exit 0
