# config file for eaterr in remote environment
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
    ./common/ssh-gc.nix
  ];

  home = {
    username = "eaterr";
    homeDirectory = "/home/eaterr";
  };
}
