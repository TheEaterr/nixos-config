{
  pkgs,
  config,
  lib,
  ...
}: {
  # Toggle scheme between light and dark, taken from https://discourse.nixos.org/t/home-manager-toggle-between-themes/32907
  scheme = {
    slug = "dark";
    scheme = "Graphite orange dark theme";
    author = "Eaterr";
    base00 = "0C0C0C"; # Black
    base01 = "2C2C2C";
    base02 = "4C4C4C";
    base03 = "7C7C7C";
    base04 = "9C9C9C";
    base05 = "BCBCBC";
    base06 = "ECECEC";
    base07 = "FCFCFC"; # White
    base08 = "ff4136"; # Red
    base09 = "fb8c00"; # Orange
    base0A = "ffdc00"; # Yellow
    base0B = "2ecc40"; # Green
    base0C = "7fdbff"; # Aqua
    base0D = "0074d9"; # Blue
    base0E = "b10dc9"; # Purple
    base0F = "85144b"; # Maroon
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
    scheme = lib.mkForce {
      slug = "light";
      scheme = "Graphite orange light theme";
      author = "Eaterr";
      base00 = "FCFCFC";
      base01 = "ECECEC";
      base02 = "9C9C9C";
      base03 = "7C7C7C";
      base04 = "5C5C5C";
      base05 = "4C4C4C";
      base06 = "2C2C2C";
      base07 = "0C0C0C"; # Black
      base08 = "ff4136"; # Red
      base09 = "fb8c00"; # Orange
      base0A = "826601"; # Yellow
      base0B = "307a01"; # Green
      base0C = "01747a"; # Aqua
      base0D = "0b017a"; # Blue
      base0E = "b10dc9"; # Purple
      base0F = "85144b"; # Maroon
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
      .${config.scheme.slug};
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
      .${config.scheme.slug};
  };
}
