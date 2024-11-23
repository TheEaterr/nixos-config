# Just command helpers

help:
    echo "Helper commands to navigate NixOS and home-manager configurations"

# Switch to a new NixOS generation
switch:
    just update-secrets
    sudo nixos-rebuild switch --flake .#framework --override-input nixos-secrets ../nixos-secrets

# Switch to home-manager configs
eaterr:
    home-manager switch -b backup --flake .#eaterr
ubuntu:
    home-manager switch -b backup --flake .#ubuntu
pbreuil:
    home-manager switch -b backup --flake .#pbreuil

# Update the boot menu
boot:
    sudo nixos-rebuild boot --flake .#framework --override-input nixos-secrets ../nixos-secrets

# Rollback to the previous NixOS generation
rollback:
    sudo nixos-rebuild switch --rollback --flake .#framework --override-input nixos-secrets ../nixos-secrets

prune: 
    nix-collect-garbage -d
    sudo nix-collect-garbage -d # Do not forget sudo, else it will not remove the old generations

# Update the secrets flakes input
update-secrets:
    nix flake lock --update-input nixos-secrets

update:
    nix flake update