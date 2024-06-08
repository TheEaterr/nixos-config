{config, ...}: {
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
      frame_width = 2;
      frame_color = "#${config.colorScheme.palette.base09}";
      width = 300;
      height = 100;
    };

    urgency_low = {
      background = "#${config.colorScheme.palette.base01}bb";
      foreground = "#${config.colorScheme.palette.base07}";
    };
    urgency_normal = {
      background = "#${config.colorScheme.palette.base01}bb";
      foreground = "#${config.colorScheme.palette.base07}";
    };
    urgency_critical = {
      background = "#${config.colorScheme.palette.base01}";
      foreground = "#${config.colorScheme.palette.base07}";
      frame_color = "#${config.colorScheme.palette.base08}";
    };
  };
}
