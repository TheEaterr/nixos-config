{
  pkgs,
  config,
  lib,
  ...
}: {
  catppuccin.accent = config.theme.${config.theme.variant}.accent;
  catppuccin.flavor = config.theme.${config.theme.variant}.flavor;

  console.catppuccin.enable = true;

  specialisation.light.configuration = {
    config.theme.variant = "light";
  };

  # Override packages
  nixpkgs.config.packageOverrides = pkgs: {
    discord = pkgs.discord.override {
      # withOpenASAR = true;
      withTTS = true;
    };
  };

  # allow switching between light and dark themes without sudo
  security.sudo = {
    extraRules = [
      {
        commands = [
          {
            command = "/nix/var/nix/profiles/system/bin/switch-to-configuration";
            options = ["NOPASSWD"];
          }
          {
            command = "/nix/var/nix/profiles/system/specialisation/light/bin/switch-to-configuration";
            options = ["NOPASSWD"];
          }
        ];
        groups = ["wheel"];
      }
    ];
  };
}
