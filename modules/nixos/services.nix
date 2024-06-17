{pkgs, ...}: {
  services.flatpak.enable = true;
  services.upower.enable = true;
  programs.fish.enable = true;
  programs.dconf.enable = true;
  services.dbus.enable = true;
  services.tumbler.enable = true;
  services.fwupd.enable = true;
  programs.light.enable = true;
  services.geoclue2.enable = true;
  programs.thunar.enable = true;

  # for auto mounting drives
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;

  # so nextcloud stays connected
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  services.geoclue2.appConfig = {
    "gammastep" = {
      isAllowed = true;
      isSystem = false;
      users = ["1000"];
    };
  };

  environment.systemPackages = with pkgs; [
    gammastep
  ];
}
