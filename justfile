# Just command helpers

help:
    echo "Helper commands to navigate NixOS and home-manager configurations"

# Switch to a new NixOS generation
switch:
    just update-secrets
    sudo nixos-rebuild switch --flake .#$(hostname) --override-input nixos-secrets ../nixos-secrets

switch-light:
    just update-secrets
    sudo nixos-rebuild switch --specialisation light --flake .#$(hostname) --override-input nixos-secrets ../nixos-secrets

# Switch to home-manager configs
user-switch:
    home-manager switch -b backup --flake .#(echo $USER)

rootless-switch:
    home-manager switch -b backup --flake .#(echo $USER)_rootless

# Update the boot menu
boot:
    sudo nixos-rebuild boot --flake .#$(hostname) --override-input nixos-secrets ../nixos-secrets

# Rollback to the previous NixOS generation
rollback:
    sudo nixos-rebuild switch --rollback --flake .#$(hostname) --override-input nixos-secrets ../nixos-secrets

prune: 
    nix-collect-garbage -d
    sudo nix-collect-garbage -d # Do not forget sudo, else it will not remove the old generations

# Update the secrets flakes input
update-secrets:
    nix flake update nixos-secrets

update:
    nix flake update

format:
    nix fmt