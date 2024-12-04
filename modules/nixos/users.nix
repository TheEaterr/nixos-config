{pkgs, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eaterr = {
    isNormalUser = true;
    description = "Paul Breuil";
    shell = pkgs.fish;
    extraGroups = ["networkmanager" "input" "wheel" "video" "audio" "tss" "docker"];
  };
}
