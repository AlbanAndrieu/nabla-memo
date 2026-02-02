#!/bin/bash
sudo apt-get update&&  sudo apt-get install -y \
  build-essential \
  libssl-dev \
  uuid-dev \
  libgpgme11-dev \
  squashfs-tools
cd /home/albandrieu/w/follow
git clone https://github.com/sylabs/singularity.git
cd singularity
go get -u -v github.com/golang/dep/cmd/dep
./mconfig --without-seccomp --without-conmon
make -C builddir
sudo make -C builddir install
ll /usr/local/bin/singularity
singularity --version
singularity verify container.sif
exit 0
