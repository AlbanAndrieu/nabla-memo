#!/bin/bash
set -xv
sudo apt install --no-install-recommends pass git pwgen xclip gnupg2
sudo apt install pass
gpg2 --gen-key
gpg2 --full-generate-key
pass init nabla@albandrieu.com
pass git init
pass git remote add origin git@github.com:AlbanAndrieu/password-store.git
pass git push -u --all
pass init "35A6FBF1C59ECF2E3784818D05D23C3B33AC3AAF"
sudo apt install golang-docker-credential-helpers
pass insert docker-credential-helpers/docker-pass-initialized-check
pass git push -u --all
gpg2 --list-keys
gpg --list-secret-keys --keyid-format LONG
pass git init 35A6FBF1C59ECF2E3784818D05D23C3B33AC3AAF
gpg2 --edit-key 35A6FBF1C59ECF2E3784818D05D23C3B33AC3AAF
echo '{ "credsStore": "pass" }' > ~/.docker/config.json
docker logout
docker login
git config --global user.signingkey F4C4B79A80826A5E5ADAD2C8B12DECD437E9E1C8
test -r ~/.bash_profile&&  echo 'export GPG_TTY=$(tty)' >> ~/.bash_profile
echo 'export GPG_TTY=$(tty)' >> ~/.profile
gpg --delete-key 7722D168DAEC457806C96FF9644FF454C0B4115C
gpg --armor --export F4C4B79A80826A5E5ADAD2C8B12DECD437E9E1C8
pass
geany ~/.gnupg/gpg-agent.conf
gpg2 --list-keys
gpg2 --export -a F4C4B79A80826A5E5ADAD2C8B12DECD437E9E1C8 > public.asc
gpg2 --export-secret-key -a F4C4B79A80826A5E5ADAD2C8B12DECD437E9E1C8 > private.asc
gpg2 --export -a 35A6FBF1C59ECF2E3784818D05D23C3B33AC3AAF > public-password-store.asc
gpg2 --export-secret-key -a 35A6FBF1C59ECF2E3784818D05D23C3B33AC3AAF > private-password-store.asc
ll ~/.password-store
gpg2 --import public.asc
gpg2 --allow-secret-key-import --import private.asc
gpg --list-secret-keys --keyid-format LONG alban.andrieu@free.fr
sec rsa4096/B12DECD437E9E1C8 2022-04-22 [SC]
F4C4B79A80826A5E5ADAD2C8B12DECD437E9E1C8
gpg --armor --export B12DECD437E9E1C8
git config --global user.signingkey F4C4B79A80826A5E5ADAD2C8B12DECD437E9E1C8
git config --global commit.gpgsign true
./run-yubikey.sh
git config --global gpg.ssh.allowedSignersFile ~/.ssh/allowed_signers
git log --show-signature
pass insert JusMundi/a.andrieu@jusmundi.com
pass JusMundi/a.andrieu@jusmundi.com
gpg --batch --import "/tmp/private.asc"
echo "key-password"|  PASSPHRASE="key-password" gpg --batch --pinentry-mode loopback --command-fd 0 -r test@example.com -d "/tmp/file.gpg" > "/tmp/file"
pass show docker-credential-helpers/aHR0cHM6Ly9pbmRleC5kb2NrZXIuaW8vdjEv
sudo apt install gnome-keysign gpa
gpa
sudo apt install seahorse
ll ~/.local/share/keyrings
./run-secret-tool.sh
./run-gpg-decrypt.sh
./run-metabase.sh
exit 0
