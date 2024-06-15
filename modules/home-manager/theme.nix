{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.base16.homeManagerModule
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  # Toggle scheme between light and dark, taken from https://discourse.nixos.org/t/home-manager-toggle-between-themes/32907
  scheme = "${inputs.tt-schemes}/base16/catppuccin-${config.theme.dark.flavor}.yaml";
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "toggle-theme";
      runtimeInputs = with pkgs; [home-manager coreutils ripgrep];
      text = ''
        "$(home-manager generations | head -1 | rg -o '/[^ ]*')"/specialisation/light/activate
      '';
    })
  ];

  specialisation.light.configuration = {
    scheme = lib.mkForce "${inputs.tt-schemes}/base16/catppuccin-${config.theme.light.flavor}.yaml";

    home.packages = with pkgs; [
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

  theme.base16Accent =
    {
      light = config.scheme.${config.theme.light.base16Accent};
      dark = config.scheme.${config.theme.dark.base16Accent};
    }
    .${config.scheme.variant};
  catppuccin.accent = config.theme.${config.scheme.variant}.accent;
  catppuccin.flavor = config.theme.${config.scheme.variant}.flavor;

  programs.btop.enable = true;
  programs.btop.catppuccin.enable = true;
  programs.zellij.enable = true;
  programs.zellij.catppuccin.enable = true;
}
