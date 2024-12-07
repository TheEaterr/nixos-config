# A Hyprland Catpuccin powered NixOS and home manager configuration

<div align="center">
<a href="https://nixos.org/">
    <img src="https://img.shields.io/badge/NixOS-24.11-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41"></a>
<a href="https://github.com/ryan4yin/nixos-and-flakes-book">
    <img src="https://img.shields.io/static/v1?label=Nix Flakes&message=enabled&style=for-the-badge&logo=nixos&color=DDB6F2&logoColor=D9E0EE&labelColor=302D41"></a>
</a>
<a href="https://hyprland.org/">
    <img src="https://img.shields.io/static/v1?label=Hyprland&message=fully%20featured&style=for-the-badge&logo=hyprland&color=00cfe6&logoColor=00cfe6&labelColor=302D41">
</a>
</div>

This is my NixOS and home manager configuration⚙️, for both NixOS native hosts or standard machines through home manager.

It features:
- ❄️ A completely deterministic and reproducible environment using Nix with flakes enabled.
- 💧 A fully featured Hyprland configuration.
- 🐱 Theming fully parametrized by catpuccin flavor and accent, using catpuccin.nix and base16.
- 🌒 Live theme switching capabilities, for both local and remote hosts.
- 🔒 Secret management using another private repository and sops-nix.
- 📖 Justfile powered commands for easy management.

<div align="center">
<img src="./showcase.gif" alt="Showcase of the aspect of the configuration" height="500/home/eaterr/nixos-config/README.md">
</div>

Special thanks to this [repository](https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles) by XNM1 from which this config was inspired.

## 🚦 Getting started

The configuration can be easily managed using `just` and the commands in the `justfile`.

### ❄️ NixOS

Add a new host in the `nixos` folder, update `flake.nix` accordingly, then run:

```
sudo nixos-rebuild switch --flake .#<host> –extra-experimental-features nix-command –extra-experimental-features flakes
```

### 🏠 Home manager

Add a new host in the `home-manager` folder, update `flake.nix` accordingly, then run:

```
nix run --extra-experimental-features nix-command --extra-experimental-features flakes home-manager -- --extra-experimental-features nix-command --extra-experimental-features flakes switch -b backup --flake .#<user>
```

## 🎨🖌 Theming

Theming is done through the [`catpuccin.nix`](https://github.com/catppuccin/nix) 🐱 project and [`base16`](https://github.com/SenchoPens/base16.nix). Two parallel configurations exist, one light ☀️ and one dark 🌙, and their flavor and accent color can be configured in the file `modules/nixos/theme-colors.nix` by modifying the following lines:

```
lightFlavor = "latte";
darkFlavor = "mocha";
lightAccent = "peach";
darkAccent = "peach";
```

Live switching 🕹 between light and dark mode can be done by using the `toggle-theme` shell command, by pressing `SUPER + N` or by using the button in the waybar. Reloading can also be synced in remote hosts 🌐 using the alias `tssh` (instead of `ssh`), which will switch the mode in the remote host to the one used locally.

## 🤫 Secrets

Secrets are managed through another private repository 🔒 using [`sops-nix`](https://github.com/Mic92/sops-nix). By default, an empty template available at https://github.com/TheEaterr/nixos-secrets-empty is used. To use a specific secrets repository, the `--override-input` flag can be used (see the `justfile`).