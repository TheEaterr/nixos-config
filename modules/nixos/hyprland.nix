{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  environment.systemPackages = with pkgs; [
    pyprland
    hyprpicker
    unstable.hyprcursor
    unstable.hyprlock
    unstable.hypridle
    unstable.hyprpaper

    imv
    kitty
    avizo
    unstable.wlr-layout-ui
    wlr-randr
  ];
}