{ pkgs, ... }:

{
  programs.firefox.enable = true;
  
  environment.systemPackages = with pkgs; [
    psi-notify
    poweralertd
    playerctl
    psmisc
    grim
    slurp
    imagemagick
    swappy
    ffmpeg_6-full
    wl-screenrec
    wl-clipboard
    wl-clip-persist
    cliphist
    xdg-utils
    wtype
    wlrctl
    waybar
    rofi-wayland
    dunst
    wlogout
    git
    chezmoi
    micro
    steam-run
    zellij
    ripgrep
    jq
    cmatrix
    networkmanagerapplet
    wev
    btop
    vim
  ];
}
