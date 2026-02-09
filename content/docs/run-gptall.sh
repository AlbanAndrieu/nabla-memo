#!/bin/bash
set -xv

# https://flathub.org/apps/io.gpt4all.gpt4all
# flatpak install flathub io.gpt4all.gpt4all
# flatpak run io.gpt4all.gpt4all

# install by hand
# mv ~/Downloads/gpt4all-installer-linux.run /data/gpt4all/
# ./data/gpt4all-installer-linux.run

/data/gpt4all/bin/chat

exit 0
