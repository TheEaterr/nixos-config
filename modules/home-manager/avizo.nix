{
  config,
  inputs,
  ...
}: {
  services.avizo.enable = true;
  services.avizo.settings = {
    default = {
      background = "rgba(${inputs.nix-colors.lib.conversions.hexToRGBString "," "${config.colorScheme.palette.base01}"}, 0.6)";
      border-color = "#${config.colorScheme.palette.base09}";
      bar-fg-color = "#${config.colorScheme.palette.base07}";
      border-width = 2;
    };
  };
}
