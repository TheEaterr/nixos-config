# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  theme = import ./theme.nix;
  waybar = import ./waybar.nix;
  hyprland = import ./hyprland.nix;
  rofi = import ./rofi.nix;
  dunst = import ./dunst.nix;
  wlogout = import ./wlogout.nix;
  avizo = import ./avizo.nix;
  kitty = import ./kitty.nix;
  background = import ./background.nix;
  hypridle = import ./hypridle.nix;
  hyprlock = import ./hyprlock.nix;
  hyprpaper = import ./hyprpaper.nix;
  pyprland = import ./pyprland.nix;
}
