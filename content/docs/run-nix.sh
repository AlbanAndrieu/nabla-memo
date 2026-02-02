#!/bin/bash
set -xv
curl -fsSL https://install.determinate.systems/nix|  sh -s -- install
sudo determinate-nixd upgrade
sudo apt install nix-bin
nix-env --install --attr devenv -f https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable
nix-shell
nix-shell -pure
nix-env -i hello
echo $NIX_PATH
export NIX_PATH="nixpkgs=/nix/var/nix/profiles/per-user/albanandrieu/channels/nixpkgs:/nix/var/nix/profiles/per-user/albanandrieu/channels"
export NIX_PATH="nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs:/nix/var/nix/profiles/per-user/root/channels"
nix-channel --add https://nixos.org/channels/nixos-25.05 nixpkgs
sudo -i nix-channel --update nixpkgs
nix-channel --update nixpkgs
sudo service nix-daemon status
nix-env -iA cachix -f https://cachix.org/api/v1/install
echo "trusted-users = root $USER"|    sudo tee -a /etc/nix/nix.conf&&  sudo pkill nix-daemon
cachix use devenv
nix-shell -p postgresql_18 -I nixpkgs=channel:nixos-25.11
nix config show|  grep lazy
                              echo -n "nix.custom.conf: "
                                                            grep lazy /etc/nix/nix.custom.conf
                                                                                                 echo -n "nix.conf: "
                                                                                                                        grep lazy /etc/nix/nix.conf
sudo geany /etc/nix/nix.custom.conf
sudo geany /etc/nix/nix.conf
exit 0
