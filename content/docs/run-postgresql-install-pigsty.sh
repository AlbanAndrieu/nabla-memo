#!/bin/bash
set -xv

# https://medium.com/@fengruohang/the-idea-way-to-deliver-postgresql-extensions-35646464bb71
# https://pigsty.cc/

curl -fsSL https://repo.pigsty.io/get | bash; cd ~/pigsty;
./bootstrap; ./configure; ./install.yml;

exit 0
