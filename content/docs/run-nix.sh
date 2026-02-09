#!/bin/bash
set -xv

# https://nixos.org/download/

# sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
# curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
sudo determinate-nixd upgrade

sudo apt install nix-bin
nix-env --install --attr devenv -f https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable

nix-shell
nix-shell -pure
# DEBUG with
# nix-shell -p nix-info --run "nix-info -m"

nix-env -i hello

echo $NIX_PATH

# Change
export NIX_PATH="nixpkgs=/nix/var/nix/profiles/per-user/albanandrieu/channels/nixpkgs:/nix/var/nix/profiles/per-user/albanandrieu/channels"
# by
export NIX_PATH="nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs:/nix/var/nix/profiles/per-user/root/channels"

nix-channel --add https://nixos.org/channels/nixos-25.05 nixpkgs
sudo -i nix-channel --update nixpkgs
nix-channel --update nixpkgs

sudo service nix-daemon status

# See https://zerotomastery.io/blog/how-to-set-up-a-development-environment-with-devenv/

# https://devenv.sh/getting-started/#3-configure-a-github-access-token-optional

nix-env -iA cachix -f https://cachix.org/api/v1/install
echo "trusted-users = root ${USER}" | sudo tee -a /etc/nix/nix.conf && sudo pkill nix-daemon
cachix use devenv

nix-shell -p postgresql_18 -I nixpkgs=channel:nixos-25.11

nix config show | grep lazy ; echo -n "nix.custom.conf: " ; grep lazy /etc/nix/nix.custom.conf ; echo -n "nix.conf: " ; grep lazy /etc/nix/nix.conf
sudo geany /etc/nix/nix.custom.conf
sudo geany /etc/nix/nix.conf

# replace fetchTarball
# https://channels.nixos.org/4eb32950fc7c3d5ad7a297dc2af190df74a86bee/nixexprs.tar.xz
# by
# Get the commit of https://github.com/NixOS/nixpkgs/blame/4eb32950fc7c3d5ad7a297dc2af190df74a86bee/pkgs/applications/networking/cluster/terraform/default.nix
# https://github.com/NixOS/nixpkgs/archive/4eb32950fc7c3d5ad7a297dc2af190df74a86bee.tar.gz

exit 0
