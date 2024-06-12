{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  # Toggle scheme between light and dark, taken from https://discourse.nixos.org/t/home-manager-toggle-between-themes/32907
  scheme = "${inputs.tt-schemes}/base16/catppuccin-${config.theme.dark.flavor}.yaml";
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
    scheme = lib.mkForce "${inputs.tt-schemes}/base16/catppuccin-${config.theme.light.flavor}.yaml";

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

  catppuccin.accent = config.theme.${config.scheme.variant}.accent;
  catppuccin.flavor = config.theme.${config.scheme.variant}.flavor;

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
    accentUpper = mkUpper config.theme.dark.accent;
    flavorUpper = mkUpper config.theme.dark.flavor;
  in {
    gtk.enable = true;
    name = "Catppuccin-${flavorUpper}-${accentUpper}-Cursors";
    package = pkgs.catppuccin-cursors.${config.theme.dark.flavor + accentUpper};
  };

  programs.btop.enable = true;
  programs.btop.catppuccin.enable = true;
  programs.zellij.enable = true;
  programs.zellij.catppuccin.enable = true;
}
