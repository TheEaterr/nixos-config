# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  theme = import ./theme.nix;
  micro = import ./micro.nix;
  fish = import ./fish.nix;

  themeGUI = import ./gui/theme-gui.nix;
  waybar = import ./gui/waybar.nix;
  hyprland = import ./gui/hyprland.nix;
  rofi = import ./gui/rofi.nix;
  dunst = import ./gui/dunst.nix;
  direnv = import ./gui/direnv.nix;
  wlogout = import ./gui/wlogout.nix;
  avizo = import ./gui/avizo.nix;
  kitty = import ./gui/kitty.nix;
  background = import ./gui/background.nix;
  hypridle = import ./gui/hypridle.nix;
  hyprlock = import ./gui/hyprlock.nix;
  hyprpaper = import ./gui/hyprpaper.nix;
  pyprland = import ./gui/pyprland.nix;
  hyprlandFishApps = import ./gui/hyprland-fish-apps.nix;
  nextcloud = import ./gui/nextcloud.nix;
}
