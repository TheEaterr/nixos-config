#!/bin/bash

set -ex
export PATH=$PATH:$HOME/.local/bin
mkdir -p $HOME/.local/bin
pushd $HOME/.local/bin

# Download nix-portable
curl -L "https://github.com/DavHau/nix-portable/releases/latest/download/nix-portable-$(uname -m)" > ./nix-portable

# Generate symlinks for seamless integration
chmod +x nix-portable
ln -s nix-portable nix
ln -s nix-portable nix-channel
ln -s nix-portable nix-copy-closure
ln -s nix-portable nix-env
ln -s nix-portable nix-instantiate
ln -s nix-portable nix-prefetch-url
ln -s nix-portable nix-store
ln -s nix-portable nix-build
ln -s nix-portable nix-collect-garbage
ln -s nix-portable nix-daemon
ln -s nix-portable nix-hash
ln -s nix-portable nix-shell

popd

# Init home-manager
NP_RUNTIME=bwrap nix-portable nix shell nixpkgs#{bashInteractive,nix} <<EOF
nix run --extra-experimental-features nix-command --extra-experimental-features flakes home-manager -- --extra-experimental-features nix-command --extra-experimental-features flakes switch -b backup --flake .#pbreuil_rootless
EOF

# Make new sessions use the shell automatically
cat >~/.profile <<EOF
export PATH=$PATH:$HOME/.local/bin:$HOME/.nix-profile/bin

if [ -z "$__NIX_PORTABLE_ACTIVATED" ]; then
        export __NIX_PORTABLE_ACTIVATED=1
        NP_RUNTIME=bwrap nix-portable nix run nixpkgs#fish --offline --option -- -l 
        exit
else
        . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
fi
EOF

echo 'Please remember to relogin so that the environment gets activated'