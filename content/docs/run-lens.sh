#!/bin/bash
set -xv

# See https://docs.k8slens.dev/getting-started/install-lens/#install-lens-desktop-from-the-apt-repository

curl -fsSL https://downloads.k8slens.dev/keys/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/lens-archive-keyring.gpg >/dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/lens-archive-keyring.gpg] https://downloads.k8slens.dev/apt/debian stable main" | sudo tee /etc/apt/sources.list.d/lens.list >/dev/null
sudo apt update && sudo apt install lens
lens-desktop

# See https://github.com/nevalla/lens-resource-map-extension

@nevalla/kube-resource-map

# See https://github.com/jkroepke/lens-extension-certificate-info

# lens://app/extensions/install/lens-certificate-info

exit 0
