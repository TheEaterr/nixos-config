# config file for pbreuil in remote environment
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
    ./common/ssh-base.nix
  ];

  home = {
    username = "root";
    homeDirectory = "/root";
  };
}
