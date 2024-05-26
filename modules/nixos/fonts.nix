{ pkgs, ... }:

{
  # FIXME: for flatpak, shoudl probably use some smart bindfs or something
  # also i set xdg data dirs manually in .profile, shoudl be in home manager
  fonts.fontDir.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
  ];
}