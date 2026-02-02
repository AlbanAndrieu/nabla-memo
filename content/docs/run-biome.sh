#!/bin/bash
set -xv
curl -L https://github.com/biomejs/biome/releases/download/@biomejs/biome@2.2.6/biome-linux-x64 -o biome
chmod +x biome
sudo mv biome /usr/local/bin/
biome migrate eslint --write
exit 0
