{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./ssh-base.nix
  ];

  # Add gc settings
  gc = {
    automatic = true;
    frequency = "weekly";
    options = "--delete-older-than 14d";
  };
}
