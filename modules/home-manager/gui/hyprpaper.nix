{config, ...}: {
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    wallpaper = {
      monitor = "";
      path = "~/background_3x2.jpg";
    };
    ipc = "off";
    splash = false;
  };
}
