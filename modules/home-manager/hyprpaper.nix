{config, ...}: {
  services.hyprpaper.enable  = true;
  services.hyprpaper.settings = {
    preload = "~/background_3x2.jpg"; 
    wallpaper = ",~/background_3x2.jpg";

    ipc = "off";
    splash = false;
  };
}
