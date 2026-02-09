#!/bin/bash
set -xv

# https://blog.stephane-robert.info/post/homelab-certificats-https-ssl-mkcert/

asdf plugin add mkcert https://github.com/salasrod/asdf-mkcert.git
asdf install mkcert latest
asdf set --home mkcert latest

mkcert -install
mkcert -CAROOT

mkcert 'artefacts.nabla.local' 'nabla.albandrieu.com' 'albandrieu.albandrieu.com' albandrieu localhost 127.0.0.1 ::1

ls -lrta ~/.local/share/mkcert/rootCA.pem

sudo cp artefacts.nabla.local+6.pem /etc/ssl/certs
sudo cp artefacts.nabla.local+6-key.pem /etc/ssl/private

exit 0
