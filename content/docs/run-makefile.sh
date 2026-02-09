#!/bin/bash
set -xv

# install pandoc https://pandoc.org/installing.html
sudo apt install pandoc

# https://github.com/mrtazz/checkmake

cd /home/albandrieu/w/follow/
git clone git@github.com:mrtazz/checkmake.git
cd /home/albandrieu/w/follow/checkmake
make
#make install

sudo cp checkmake /usr/local/bin/

docker run -v "$PWD"/Makefile:/Makefile checker

# vscdde do
make all --print-data-base --no-builtin-variables --no-builtin-rules --question

exit 0
