{
  pkgs,
  inputs,
  config,
  lib,
  themeParams,
  ...
}: let
  schemes = {
    light = "${inputs.tt-schemes}/base16/catppuccin-${themeParams.light.flavor}.yaml";
    dark = "${inputs.tt-schemes}/base16/catppuccin-${themeParams.dark.flavor}.yaml";
  };
  alternateVariant =
    if themeParams.variant == "light"
    then "dark"
    else "light";
in {
  imports = [
    inputs.base16.homeManagerModule
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  # Toggle scheme between light and dark, taken from https://discourse.nixos.org/t/home-manager-toggle-between-themes/32907
  config.scheme = schemes.${themeParams.variant};
  config.home.packages = with pkgs; [
    (writeShellApplication {
      name = "toggle-theme";
      runtimeInputs = with pkgs; [home-manager coreutils ripgrep];
      text = ''
        "$(home-manager generations | head -1 | rg -o '/[^ ]*')"/specialisation/alternate/activate
      '';
    })
  ];

  config.specialisation.alternate.configuration = {
    config.scheme = lib.mkForce schemes.${alternateVariant};

    config.home.packages = with pkgs; [
      # note the hiPrio which makes this script more important then others and is usually used in nix to resolve name conflicts
      (hiPrio (writeShellApplication {
        name = "toggle-theme";
        runtimeInputs = with pkgs; [home-manager coreutils ripgrep];
        # the interesting part about the script below is that we go back two generations
        # since every time we invoke a activation script home-manager creates a new generation
        text = ''
          "$(home-manager generations | head -2 | tail -1 | rg -o '/[^ ]*')"/activate
        '';
      }))
    ];
  };

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

  config.home.file.".config/current_theme".text = "${config.scheme.variant}";

  config.programs.btop.enable = true;
  config.programs.btop.catppuccin.enable = true;
  config.programs.zellij.enable = true;
  config.programs.zellij.catppuccin.enable = true;
}
