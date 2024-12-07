{
  pkgs,
  outputs,
  ...
}: let
  tw-cen-regular = pkgs.callPackage pkgs.stdenv.mkDerivation {
    name = "tw-cen-regular";
    version = "1.0";
    src = outputs.assets.tw-cen-mt-regular;

    unpackPhase = ''
      runHook preUnpack
      ${pkgs.unzip}/bin/unzip $src

      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall
      install -Dm644 "Tw Cen MT Regular/Tw Cen MT Regular.ttf" -t $out/share/fonts/truetype
      runHook postInstall
    '';
  };
in {
  # FIXME: for flatpak, shoudl probably use some smart bindfs or something
  # also i set xdg data dirs manually in .profile, shoudl be in home manager
  fonts.fontDir.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    nerdfonts
    tw-cen-regular
  ];
}
