#!/bin/bash
curl -sS https://starship.rs/install.sh|  sh
sudo apt install starship
eval "$(starship init bash)"
exit 0
