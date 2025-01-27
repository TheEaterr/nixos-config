# config file for ubuntu in remote environment
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
    username = "ubuntu";
    homeDirectory = "/home/ubuntu";
  };
}
