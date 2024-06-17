# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    ./base.nix
    outputs.sharedModules.themeColors
    outputs.homeManagerModules.theme
  ];

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    package = pkgs.nix;
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
    };
    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;

    # Add gc settings
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  home = {
    username = "eaterr";
    homeDirectory = "/home/eaterr";
  };

  programs.fish.enable = true;
  programs.fish.interactiveShellInit = ''
    echo "Current theme: $(cat ~/.config/current_theme)"
    echo "Remote theme: $LC_THEME"
    if [ $LC_THEME != $(cat ~/.config/current_theme) ]; then
      echo "Setting theme to $LC_THEME"
      fish -c "toggle-theme"
    fi
  '';
}
