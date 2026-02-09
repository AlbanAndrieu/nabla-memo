#!/bin/bash
set -xv

sudo apt install --no-install-recommends pass git pwgen xclip gnupg2

# See https://wiki.gnome.org/Apps/Seahorse
# Best editor seahorse

#/home/albandrieu/.gnupg/openpgp-revocs.d

sudo apt install pass # Install Pass

# As jenkins user
# Issue is not ssh  (https://unix.stackexchange.com/questions/477445/www-data-user-cannot-generate-gpg-key)
#ssh -X jenkins@albandrieu
gpg2 --gen-key
# with passphase
#80152EA5516E63F8023D581A27364DBFFDB85EF9

gpg2 --full-generate-key # Create public-private key
# passphase
#35A6FBF1C59ECF2E3784818D05D23C3B33AC3AAF

# for "albandrieu"
# See https://git.zx2c4.com/password-store/about/#EXTENDED%20GIT%20EXAMPLE
pass init nabla@albandrieu.com
pass git init

pass git remote add origin git@github.com:AlbanAndrieu/password-store.git
pass git push -u --all

# for "albandrieu"
pass init "35A6FBF1C59ECF2E3784818D05D23C3B33AC3AAF"

sudo apt install golang-docker-credential-helpers
#ls -lrta /usr/bin/docker-credential-pass
#ls -lrta /usr/bin/docker-credential-secretservice

pass insert docker-credential-helpers/docker-pass-initialized-check
pass git push -u --all

gpg2 --list-keys
# for "albandrieu"
# Below key is not secret
# 4DAE02DFBAB132A6CE3F9DBE4E61BDC8F377CFFD
#gpg2 --list-secret-keys
gpg --list-secret-keys --keyid-format LONG
pass git init 35A6FBF1C59ECF2E3784818D05D23C3B33AC3AAF
gpg2 --edit-key 35A6FBF1C59ECF2E3784818D05D23C3B33AC3AAF
#then you have to trust your own key first (gpg --edit-key 64290B2D, trust, 5, save).

#nano ~/.docker/config.json
echo '{ "credsStore": "pass" }' >~/.docker/config.json

docker logout
docker login
#...

git config --global user.signingkey F4C4B79A80826A5E5ADAD2C8B12DECD437E9E1C8
test -r ~/.bash_profile && echo 'export GPG_TTY=$(tty)' >>~/.bash_profile
echo 'export GPG_TTY=$(tty)' >>~/.profile

gpg --delete-key 7722D168DAEC457806C96FF9644FF454C0B4115C
#gpg --armor --export 35A6FBF1C59ECF2E3784818D05D23C3B33AC3AAF
gpg --armor --export F4C4B79A80826A5E5ADAD2C8B12DECD437E9E1C8

pass

geany ~/.gnupg/gpg-agent.conf
# Add allow-loopback-pinentry

# For user with no ui as jenkins
#geany ~/.gnupg/gpg.conf
# Add
# pinentry-mode loopback

#albandrieu-dell-5420
gpg2 --list-keys

# Used for git
# [ultimate] Alban Andrieu (Nabla) <alban.andrieu@free.fr>
gpg2 --export -a F4C4B79A80826A5E5ADAD2C8B12DECD437E9E1C8 >public.asc
gpg2 --export-secret-key -a F4C4B79A80826A5E5ADAD2C8B12DECD437E9E1C8 >private.asc

# Add public.asc to
# https://gitlab.com/-/profile/gpg_keys
# https://github.com/settings/keys

# aandrieu
# Used for https://github.com/AlbanAndrieu/pass-docker-credential-helpers
# [ultimate] Alban Andrieu (GPG key for docker credentials) <alban.andrieu@free.fr>
gpg2 --export -a 35A6FBF1C59ECF2E3784818D05D23C3B33AC3AAF >public-password-store.asc
gpg2 --export-secret-key -a 35A6FBF1C59ECF2E3784818D05D23C3B33AC3AAF >private-password-store.asc

# [ unknown] Alban Andrieu <alban.andrieu@nabla.mobi>
#The key has only a public part
#gpg2 --export -a 4DAE02DFBAB132A6CE3F9DBE4E61BDC8F377CFFD > public.asc
#gpg2 --export-secret-key -a 4DAE02DFBAB132A6CE3F9DBE4E61BDC8F377CFFD > private.asc

# gpg-flowcrypt-gmail
# [ unknown] Alban Andrieu <alban.andrieu@nabla.mobi>
#gpg2 --export -a 8DBE47A90398D86125B08C2407A299515B57447F > public.asc

# On other computer
ll ~/.password-store

gpg2 --import public.asc
gpg2 --allow-secret-key-import --import private.asc

# For gitlab https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/index.html
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

# See https://www.rzegocki.pl/blog/how-to-make-gnupg2-to-fall-in-love-with-docker/
gpg --batch --import "/tmp/private.asc"

echo "key-password" | PASSPHRASE="key-password" gpg --batch --pinentry-mode loopback --command-fd 0 -r test@example.com -d "/tmp/file.gpg" >"/tmp/file"

pass show docker-credential-helpers/aHR0cHM6Ly9pbmRleC5kb2NrZXIuaW8vdjEv

# See https://doc.ubuntu-fr.org/gnupg
sudo apt install gnome-keysign gpa

# Nice manager gpg ui
gpa

sudo apt install seahorse # seahorse-nautilus
ll ~/.local/share/keyrings

./run-secret-tool.sh

# vscodegitlab.workflow/gitlab-tokens

./run-gpg-decrypt.sh

./run-metabase.sh

exit 0
