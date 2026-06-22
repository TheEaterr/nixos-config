{
  pkgs,
  inputs,
  config,
  lib,
  themeParams,
  ...
}: {
  imports = [
    inputs.base16.homeManagerModule
    inputs.catppuccin.homeModules.catppuccin
  ];

  options.hexAccent = lib.mkOption {
    type = lib.types.str;
    default = "ffffff";
  };
  config.hexAccent =
    {
      light = config.scheme.${themeParams.light.base16Accent};
      dark = config.scheme.${themeParams.dark.base16Accent};
    }
    .${config.scheme.variant};
  config.catppuccin.accent = themeParams.${config.scheme.variant}.accent;
  config.catppuccin.flavor = themeParams.${config.scheme.variant}.flavor;
  config.catppuccin.autoEnable = true;
  config.catppuccin.enable = true;

  config.home.file.".config/current_theme".text = "${config.scheme.variant}";

  config.programs.btop.enable = true;
  config.catppuccin.btop.enable = true;
  config.programs.zellij.enable = true;
  config.catppuccin.zellij.enable = true;
}
