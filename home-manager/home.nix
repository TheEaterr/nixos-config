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
    # If you want to use modules your own flake exports (from modules/home-manager):
    outputs.sharedModules.themeColors
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
  ];

  home = {
    username = "eaterr";
    homeDirectory = "/home/eaterr";
  };
}
