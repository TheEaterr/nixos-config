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

  catppuccin.accent = config.theme.${config.scheme.slug}.accent;
  catppuccin.flavor = config.theme.${config.scheme.slug}.flavor;

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


  # Have to manually specify cursors for it to work (no clue why)
  # Cursor change is also a bit wonky so we just use the dark cursor theme
  # Light cursor is hard to see on light backgrounds anyway
  home.pointerCursor = let
    # taken from https://github.com/catppuccin/nix/blob/d34a94a17c6ec4a0c4e24b3e4336ea504d021f6d/modules/lib/default.nix#L63
    mkUpper =
        str:
          (lib.toUpper (builtins.substring 0 1 str)) + (builtins.substring 1 (builtins.stringLength str) str);
    accentUpper = mkUpper config.theme.dark.accent;
    flavorUpper = mkUpper config.theme.dark.flavor;
  in
  {
    gtk.enable = true;
    name = "Catppuccin-${flavorUpper}-${accentUpper}-Cursors";
    package = pkgs.catppuccin-cursors.${config.theme.dark.flavor + accentUpper};
  };

  programs.btop.enable = true;
  programs.btop.catppuccin.enable = true;
  programs.zellij.enable = true;
  programs.zellij.catppuccin.enable = true;
}
