{
  pkgs,
  config,
  lib,
  ...
}: {

  catppuccin.accent = lib.mkDefault config.theme.dark.accent;
  catppuccin.flavor = lib.mkDefault config.theme.dark.flavor;

  specialisation.light.configuration = {
    catppuccin.accent = config.theme.light.accent;
    catppuccin.flavor = config.theme.light.flavor;
  };

  console.catppuccin.enable = true;

  # Override packages
  nixpkgs.config.packageOverrides = pkgs: {
    discord = pkgs.discord.override {
      # withOpenASAR = true;
      withTTS = true;
    };
  };
}
