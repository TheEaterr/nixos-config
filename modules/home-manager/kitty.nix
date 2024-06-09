{
  config,
  inputs,
  ...
}: {
  programs.kitty.enable = true;

  programs.kitty.settings = {
    confirm_os_window_close = 0;
  };

  programs.kitty.font.name = "JetBrains Mono NL Bold";

  # Modified from https://github.com/kdrag0n/base16-kitty/blob/master/templates/default.mustache
  programs.kitty.extraConfig = builtins.readFile (config.scheme {
    template = ''
          # Base16 {{scheme-name}} - kitty color config
      # Scheme by {{scheme-author}}
      background #{{base00-hex}}
      foreground #{{base07-hex}}
      selection_background #{{base07-hex}}
      selection_foreground #{{base00-hex}}
      url_color #{{base04-hex}}
      cursor #{{base07-hex}}
      active_border_color #{{base03-hex}}
      inactive_border_color #{{base01-hex}}
      active_tab_background #{{base00-hex}}
      active_tab_foreground #{{base07-hex}}
      inactive_tab_background #{{base01-hex}}
      inactive_tab_foreground #{{base04-hex}}
      tab_bar_background #{{base01-hex}}
      wayland_titlebar_color #{{base00-hex}}
      macos_titlebar_color #{{base00-hex}}

      # normal
      color0 #{{base00-hex}}
      color1 #{{base08-hex}}
      color2 #{{base0B-hex}}
      color3 #{{base0A-hex}}
      color4 #{{base0D-hex}}
      color5 #{{base0E-hex}}
      color6 #{{base0C-hex}}
      color7 #{{base05-hex}}

      # bright
      color8 #{{base03-hex}}
      color9 #{{base09-hex}}
      color10 #{{base0B-hex}}
      color11 #{{base02-hex}}
      color12 #{{base04-hex}}
      color13 #{{base06-hex}}
      color14 #{{base0F-hex}}
      color15 #{{base07-hex}}
    '';
  });
}
