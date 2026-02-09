#!/bin/bash
#set -xv

# https://github.com/starship/starship

# ModuleNotFoundError: No module named encodings
# as root
curl -sS https://starship.rs/install.sh | sh
sudo apt install starship

#Add the following to the end of ~/.bashrc:
eval "$(starship init bash)"

exit 0
