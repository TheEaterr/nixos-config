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

  gtk = {
    enable = true;
  };
  catppuccin.gtk.icon.enable = true;
  catppuccin.gtk.enable = true;

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
  catppuccin.hyprland.enable = true;
}
