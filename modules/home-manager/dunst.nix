{
  config,
  themeParams,
  ...
}: {
  services.dunst.enable = true;
  services.dunst.settings = {
    global = {
      separator_color = "frame";
      font = "JetBrains Mono Regular 11";
      corner_radius = 15;
      offset = "10x10";
      origin = "top-right";
      notification_limit = 8;
      gap_size = 7;
      frame_width = 0;
      frame_color = "#${config.hexAccent}";
      width = 300;
      height = 100;
    };

    urgency_low = {
      background = "#${config.scheme.base01}bb";
      foreground = "#${config.scheme.base05}";
    };
    urgency_normal = {
      background = "#${config.scheme.base01}bb";
      foreground = "#${config.scheme.base05}";
    };
    urgency_critical = {
      background = "#${config.scheme.base01}";
      foreground = "#${config.scheme.base05}";
      frame_width = 2;
      frame_color = "#${config.scheme.base08}";
    };
  };
}
