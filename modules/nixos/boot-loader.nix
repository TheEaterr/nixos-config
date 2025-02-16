{ pkgs, lib, ... }: {

  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    # Using unstable as the version in nixpkgs still uses the old
    # /etc/secrureboot directory, this way migration is already done.
    pkgs.unstable.sbctl
  ];

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}