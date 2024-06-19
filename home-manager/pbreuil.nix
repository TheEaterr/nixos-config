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
    ./ssh-base.nix
  ];

  home = {
    username = "pbreuil";
    homeDirectory = "/home/pbreuil";
  };
}
