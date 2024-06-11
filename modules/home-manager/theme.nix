{
  pkgs,
  config,
  lib,
  ...
}: {
  # Toggle scheme between light and dark, taken from https://discourse.nixos.org/t/home-manager-toggle-between-themes/32907
  scheme = {
    slug = "dark";
    scheme = "Catppuccin Mocha";
    author = "https://github.com/catppuccin/catppuccin";
    base00 = "1e1e2e"; # base
    base01 = "181825"; # mantle
    base02 = "313244"; # surface0
    base03 = "45475a"; # surface1
    base04 = "585b70"; # surface2
    base05 = "cdd6f4"; # text
    base06 = "f5e0dc"; # rosewater
    base07 = "b4befe"; # lavender
    base08 = "f38ba8"; # red
    base09 = "fab387"; # peach
    base0A = "f9e2af"; # yellow
    base0B = "a6e3a1"; # green
    base0C = "94e2d5"; # teal
    base0D = "89b4fa"; # blue
    base0E = "cba6f7"; # mauve
    base0F = "f2cdcd"; # flamingo
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
      scheme = "Catppuccin Latte";
      author = "https://github.com/catppuccin/catppuccin";
      base00 = "eff1f5"; # base
      base01 = "e6e9ef"; # mantle
      base02 = "ccd0da"; # surface0
      base03 = "bcc0cc"; # surface1
      base04 = "acb0be"; # surface2
      base05 = "4c4f69"; # text
      base06 = "dc8a78"; # rosewater
      base07 = "7287fd"; # lavender
      base08 = "d20f39"; # red
      base09 = "fe640b"; # peach
      base0A = "df8e1d"; # yellow
      base0B = "40a02b"; # green
      base0C = "179299"; # teal
      base0D = "1e66f5"; # blue
      base0E = "8839ef"; # mauve
      base0F = "dd7878"; # flamingo
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

  # catppuccin.enable = true;
  catppuccin.accent = "peach";
  catppuccin.flavor =
    {
      light = "latte";
      dark = "mocha";
    }
    .${config.scheme.slug};

  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin-Mocha-Peach-Cursors";
    package = pkgs.catppuccin-cursors.mochaPeach;
  };

  qt = {
    enable = true;
    style.catppuccin.enable = true;
    style.catppuccin.apply = true;
    style.name = "kvantum";
  };

  gtk = {
    enable = true;
    catppuccin.enable = true;
    catppuccin.cursor.enable = true;
    catppuccin.icon.enable = true;
  };

  programs.btop.enable = true;
  programs.btop.catppuccin.enable = true;
  programs.zellij.enable = true;
  programs.zellij.catppuccin.enable = true;
}
