{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libsecret
  ];

  # Using GDM as the display manager allows to unlock gnome-keyring with LUKS passphrase !
  # This config was stolen from this guy:
  # https://discourse.nixos.org/t/automatically-unlocking-the-gnome-keyring-using-luks-key-with-greetd-and-hyprland/54260/3
  services.xserver.desktopManager.gnome.enable = false;
  services.xserver.excludePackages = [pkgs.xterm];
  services.gnome.core-utilities.enable = false;
  services.gnome.rygel.enable = false;
  services.xserver.displayManager.gdm.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "eaterr";

  # Use the decryption passphrase to also unlock the gnome-keyring
  boot.initrd.systemd.enable = true;
  security.pam.services = {
    gdm-autologin.text = ''
      auth      requisite     pam_nologin.so

      auth      required      pam_succeed_if.so uid >= 1000 quiet
      auth      optional      ${pkgs.gdm}/lib/security/pam_gdm.so
      auth      optional      ${pkgs.gnome-keyring}/lib/security/pam_gnome_keyring.so
      auth      required      pam_permit.so

      account   sufficient    pam_unix.so

      password  requisite     pam_unix.so nullok yescrypt

      session   optional      pam_keyinit.so revoke
      session   include       login
    '';
  };
}
