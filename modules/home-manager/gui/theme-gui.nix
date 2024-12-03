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

  catppuccin.pointerCursor.enable = true;
  wayland.windowManager.hyprland.catppuccin.enable = true;
}
