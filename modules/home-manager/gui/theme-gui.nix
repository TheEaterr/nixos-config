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
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };
  catppuccin.kvantum.apply = true;
  catppuccin.kvantum.enable = true;

  gtk = let 
    capitalizeFirst = str:
      if str == "" then ""
      else (lib.toUpper (builtins.substring 0 1 str)) + (builtins.substring 1 (builtins.stringLength str) str);
    variantCapitalized = capitalizeFirst "${config.scheme.variant}";
    accentCapitalized = capitalizeFirst "${themeParams.${config.scheme.variant}.accent}";
  in {
    enable = true;
    theme.package = (pkgs.magnetic-catppuccin-gtk.override {
      shade = "${config.scheme.variant}";
      accent = [ "${themeParams.${config.scheme.variant}.accent}" ];
    });
    theme.name = "Catppuccin-GTK-${accentCapitalized}-${variantCapitalized}";
    gtk4.theme = config.gtk.theme;
  };
  
  catppuccin.gtk.icon.enable = true;

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

  catppuccin.cursors.enable = true;
  catppuccin.hyprland.enable = false;
  catppuccin.hyprlock.enable = false;
  home.pointerCursor.gtk.enable = true;
  home.pointerCursor.size = 32;
}
