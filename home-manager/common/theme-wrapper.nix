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
  config._module.args.themeParams = config.theme;

  config.scheme = config.theme.schemes.${config.theme.variant};
  config.home.packages = with pkgs; [
    (writeShellApplication {
      name = "toggle-theme";
      runtimeInputs = with pkgs; [home-manager coreutils ripgrep];
      text = ''
        "$(home-manager generations | head -1 | rg -o '/[^ ]*')"/specialisation/alternate/activate
      '';
    })
  ];

  # Toggle scheme between light and dark, taken from https://discourse.nixos.org/t/home-manager-toggle-between-themes/32907
  # This is only used for the only home-manager configuration in ssh, and not in the main home-manager configuration where
  # the specialisation from the "upstream" nixos configuration is used.
  config.specialisation.alternate.configuration = let
    alternateVariant =
      if config.scheme.variant == "light"
      then "dark"
      else "light";
  in {
    config.scheme = lib.mkForce config.theme.schemes.${alternateVariant};

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
}
