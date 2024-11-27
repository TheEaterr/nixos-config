# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  bluetooth = import ./bluetooth.nix;
  bootLoader = import ./boot-loader.nix;
  displayManager = import ./display-manager.nix;
  distrobox = import ./distrobox.nix;
  fonts = import ./fonts.nix;
  gc = import ./gc.nix;
  hyprland = import ./hyprland.nix;
  i18n = import ./i18n.nix;
  networking = import ./networking.nix;
  nixLd = import ./nix-ld.nix;
  packages = import ./packages.nix;
  printing = import ./printing.nix;
  services = import ./services.nix;
  sound = import ./sound.nix;
  theme = import ./theme.nix;
  themeColors = import ./theme-colors.nix;
  users = import ./users.nix;
}
