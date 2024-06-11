{pkgs, ...}: {
  catppuccin.accent = "peach";
  catppuccin.flavor = "mocha";
  console.catppuccin.enable = true;

  # Override packages
  nixpkgs.config.packageOverrides = pkgs: {
    discord = pkgs.discord.override {
      withOpenASAR = true;
      withTTS = true;
    };
  };
}
