#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y curl git openssl

curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon --yes

# Source the nix profile to have access to nix commands
source /etc/profile

git clone https://github.com/TheEaterr/nixos-config.git

cd nixos-config

nix run --extra-experimental-features nix-command --extra-experimental-features flakes home-manager -- --extra-experimental-features nix-command --extra-experimental-features flakes switch -b backup --flake .#$USER
