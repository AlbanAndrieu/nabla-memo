#!/bin/bash
set -xv
sudo apt install pandoc
cd /home/albandrieu/w/follow/
git clone git@github.com:mrtazz/checkmake.git
cd /home/albandrieu/w/follow/checkmake
make
sudo cp checkmake /usr/local/bin/
docker run -v "$PWD"/Makefile:/Makefile checker
make all --print-data-base --no-builtin-variables --no-builtin-rules --question
exit 0
