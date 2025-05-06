{pkgs, ...}: {
  services.nextcloud-client.enable = true;
  # because of https://discourse.nixos.org/t/nextcloud-client-does-not-auto-start-in-gnome3/46492/7
  systemd.user.services.nextcloud-client = {
    Unit = {
      After = pkgs.lib.mkForce "graphical-session.target"; 
    };
  };
}
