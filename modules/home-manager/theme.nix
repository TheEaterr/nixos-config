{
  pkgs,
  config,
  lib,
  ...
}: {
  # Toggle scheme between light and dark, taken from https://discourse.nixos.org/t/home-manager-toggle-between-themes/32907
  colorScheme = {
    slug = "dark";
    palette = {
      base00 = "eeeeee"; # White
      base02 = "ACACAC";
      base03 = "9C9C9C";
      base04 = "7C7C7C";
      base05 = "5C5C5C";
      base01 = "CCCCCC";
      base06 = "3C3C3C";
      base07 = "1C1C1C"; # Black
      base08 = "ff4136"; # Red
      base09 = "fb8c00"; # Orange
      base0A = "ffdc00"; # Yellow
      base0B = "2ecc40"; # Green
      base0C = "7fdbff"; # Aqua
      base0D = "0074d9"; # Blue
      base0E = "b10dc9"; # Purple
      base0F = "85144b"; # Maroon
    };
  };

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
    colorScheme = lib.mkForce {
      slug = "light";
      palette = {
        base00 = "1C1C1C"; # Black
        base01 = "3C3C3C";
        base02 = "5C5C5C";
        base03 = "7C7C7C";
        base04 = "9C9C9C";
        base05 = "ACACAC";
        base06 = "CCCCCC";
        base07 = "eeeeee"; # White
        base08 = "ff4136"; # Red
        base09 = "fb8c00"; # Orange
        base0A = "ffdc00"; # Yellow
        base0B = "2ecc40"; # Green
        base0C = "7fdbff"; # Aqua
        base0D = "0074d9"; # Blue
        base0E = "b10dc9"; # Purple
        base0F = "85144b"; # Maroon
      };
    };
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

  home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 24;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    theme =
      {
        light = {
          name = "Graphite-orange-Light";
          package = pkgs.graphite-gtk-theme.override {
            themeVariants = ["orange"];
          };
        };
        dark = {
          name = "Graphite-orange-Dark";
          package = pkgs.graphite-gtk-theme.override {
            themeVariants = ["orange"];
          };
        };
      }
      .${config.colorScheme.slug};
    iconTheme =
      {
        light = {
          name = "Tela-circle-orange-light";
          package = pkgs.tela-circle-icon-theme.override {
            colorVariants = ["orange"];
          };
        };
        dark = {
          name = "Tela-circle-orange-dark";
          package = pkgs.tela-circle-icon-theme.override {
            colorVariants = ["orange"];
          };
        };
      }
      .${config.colorScheme.slug};
  };
}
