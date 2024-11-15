{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    outputs.nixosModules.themeColors
  ];

  # Pass the themeParams variable like done with nixos. Maybe not the cleanest way, but it works.
  _module.args.themeParams = config.theme;
}
