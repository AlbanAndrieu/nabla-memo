#!/bin/bash
set -xv

# Noise reduction
# https://korben.info/cadmus-pour-retirer-les-bruits-de-fonds-sous-linux.html

# https://github.com/noisetorch/NoiseTorch
wget https://github.com/noisetorch/NoiseTorch/releases/download/v0.12.2/NoiseTorch_x64_v0.12.2.tgz
tar -C $HOME -h -xzf NoiseTorch_x64_v0.12.2.tgz

gtk-update-icon-cache

exit 0
