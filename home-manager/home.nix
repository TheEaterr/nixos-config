# config file for gui environments
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  themeParams,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    ./common/base.nix
    inputs.nixos-secrets.homeManagerModules.mail
    # If you want to use modules your own flake exports (from modules/home-manager):
    outputs.homeManagerModules.theme
    outputs.homeManagerModules.themeGUI
    outputs.homeManagerModules.waybar
    outputs.homeManagerModules.hyprland
    outputs.homeManagerModules.rofi
    outputs.homeManagerModules.dunst
    outputs.homeManagerModules.wlogout
    outputs.homeManagerModules.avizo
    outputs.homeManagerModules.kitty
    outputs.homeManagerModules.background
    outputs.homeManagerModules.hypridle
    outputs.homeManagerModules.hyprlock
    outputs.homeManagerModules.hyprpaper
    outputs.homeManagerModules.pyprland
    outputs.homeManagerModules.micro
    outputs.homeManagerModules.fish
    outputs.homeManagerModules.hyprlandFishApps
    outputs.homeManagerModules.nextcloud
  ];

  config.scheme = themeParams.schemes.${themeParams.variant};
  config.home.packages = with pkgs; [
    (writeShellApplication {
      name = "toggle-theme";
      text =
        if themeParams.variant == "light"
        then ''
          dunstify "Switching to dark theme"
          sudo /nix/var/nix/profiles/system/bin/switch-to-configuration test
        ''
        else ''
          dunstify "Switching to light theme"
          sudo /nix/var/nix/profiles/system/specialisation/light/bin/switch-to-configuration test
        '';
    })
  ];

  config.home = {
    username = "eaterr";
    homeDirectory = "/home/eaterr";
  };
}
