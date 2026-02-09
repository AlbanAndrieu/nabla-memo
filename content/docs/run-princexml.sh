#!/bin/bash
set -xv

# See https://www.princexml.com/doc/installing/

# Ubuntu 20.04 / x86-64 deb
# wget https://www.princexml.com/download/prince_14.2-1_ubuntu20.04_amd64.deb
sudo dpkg -i prince_14.2-1_ubuntu20.04_amd64.deb
wget https://www.princexml.com/download/prince_15.1-1_ubuntu20.04_amd64.deb

# Ubuntu 22.04 / x86-64 deb
wget https://www.princexml.com/download/prince_15.1-1_ubuntu22.04_amd64.deb

prince --version

exit 0
