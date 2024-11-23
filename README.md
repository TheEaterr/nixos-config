# A Hyprland Catpuccin powered NixOS and home manager configuration

This is my NixOS and home manager configuration, for both NixOS native hosts or standard machines through home manager.

It features:
- ❄️ A completely deterministic and reproducible environment using Nix with flakes enabled.
- 💧 A fully featured Hyprland configuration.
- 🐱 Theming fully parametrized by catpuccin flavor and accent, using catpuccin.nix and base16.
- 🌒 Live theme switching capabilities, for both local and remote hosts.
- 🔒 Secret management using another private repository and sops-nix.
- 📖 Justfile powered commands for easy management.

<div align="center">
<img src="./showcase.gif" alt="Showcase of the aspect of the configuration" height="500">
</div>

Special thanks to this [repository](https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles) by XNM1 from which this config was inspired.

## Getting started

To use this configuration on a new host, assuming the proper corrections were made, use the commands :

```
sudo nixos-rebuild switch --flake .#<host> –extra-experimental-features nix-command –extra-experimental-features flakes
```

for NixOS or :

```
nix run --extra-experimental-features nix-command --extra-experimental-features flakes home-manager -- --extra-experimental-features nix-command --extra-experimental-features flakes switch -b backup --flake .#<user>
```

for home manager.

The configuration can then be easily managed using just and the commands in the just file.

## Theming

Theming is done through the catpuccin.nix project and base16. Two parallel configurations exist, one light and one dark, and their flavor and accent color can be configured in the file `modules/nixos/theme-colors.nix` by modifying the following lines:

```
lightFlavor = "latte";
darkFlavor = "mocha";
lightAccent = "peach";
darkAccent = "peach";
```

Live switching between light and dark mode can be done by using the `toggle-theme` shell command, by pressing `SUPER + N` or by using the button in the waybar. Reloading can also be synced in remote hosts using the alias `tssh` (instead of `ssh`), which will switch the mode in the remote host to the one used locally.

## Secrets

Secrets are managed through another private repository using sops-nix. By default, an empty template available at https://github.com/TheEaterr/nixos-secrets-empty is used. To use a specific secrets repository, the `--override-input` flag can be used (see the `justfile`).