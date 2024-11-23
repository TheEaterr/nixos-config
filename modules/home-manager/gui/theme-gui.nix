{
  pkgs,
  config,
  lib,
  themeParams,
  ...
}: {
  # need to manually reload hyprland to apply changes
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "toggle-theme-gui";
      text = ''
        toggle-theme && hyprctl reload
      '';
    })
  ];

  qt = {
    enable = true;
    style.catppuccin.enable = true;
    style.catppuccin.apply = true;
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  gtk = {
    enable = true;
    catppuccin.enable = true;
    catppuccin.icon.enable = true;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme =
          {
            dark = "prefer-dark";
            light = "";
          }
          .${config.scheme.variant};
      };
    };
  };

  # Have to manually specify cursors for it to work (no clue why)
  # Cursor change is also a bit wonky so we just use the dark cursor theme
  # Light cursor is hard to see on light backgrounds anyway
  home.pointerCursor = let
    # taken from https://github.com/catppuccin/nix/blob/d34a94a17c6ec4a0c4e24b3e4336ea504d021f6d/modules/lib/default.nix#L63
    mkUpper = str:
      (lib.toUpper (builtins.substring 0 1 str)) + (builtins.substring 1 (builtins.stringLength str) str);
    accentUpper = mkUpper themeParams.dark.accent;
    flavorUpper = mkUpper themeParams.dark.flavor;
  in {
    gtk.enable = true;
    name = "catppuccin-${themeParams.dark.flavor}-${themeParams.dark.accent}-cursors";
    package = pkgs.catppuccin-cursors.${themeParams.dark.flavor + accentUpper};
  };
}
