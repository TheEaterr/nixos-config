{pkgs, ...}: {
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
    unzip
    unstable.signal-desktop
    whatsapp-for-linux
    telegram-desktop
    nextcloud-client
    lsd
    wireshark-qt
    krita
    zoom-us
    python3
    python311Packages.pip
    inkscape
    nwg-look
    obs-studio
    libreoffice
    drawio
    onlyoffice-bin_latest
    discord
    vlc
    unstable.godot_4
    sops
    age
    gcc
    chromium
    slack
    openvpn
    jetbrains.datagrip
    jetbrains.idea-community
    dotenv-cli
    jdk21
  ];
}
