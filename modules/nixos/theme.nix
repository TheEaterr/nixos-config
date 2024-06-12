{
  pkgs,
  config,
  ...
}: {
  catppuccin.accent = config.theme.dark.accent;
  catppuccin.flavor = config.theme.dark.flavor;
  console.catppuccin.enable = true;

  # Override packages
  nixpkgs.config.packageOverrides = pkgs: {
    discord = pkgs.discord.override {
      withOpenASAR = true;
      withTTS = true;
    };
  };
}
