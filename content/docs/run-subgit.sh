#!/bin/bash
wget https://subgit.com/files/subgit_3.3.9_all.deb
sudo dpkg -i subgit_3.3.9_all.deb
sudo apt-get install -f
exit 0
