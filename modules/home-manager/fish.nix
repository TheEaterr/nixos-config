{pkgs, ...}: {
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = ''
    ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
  '';
  programs.fish.shellAliases.ls = "lsd";
  programs.fish.shellAliases.tssh = "LC_THEME=\$(cat ~/.config/current_theme) ssh -o 'SendEnv LC_THEME'";
}
