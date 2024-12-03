{pkgs, ...}: {
  # virtualisation.podman = {
  #   enable = true;
  #   dockerCompat = true;
  # };
  virtualisation.docker.enable = true;

  environment.systemPackages = [ pkgs.distrobox ];
}
