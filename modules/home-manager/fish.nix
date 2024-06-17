{...}: {
  programs.fish.enable = true;
  programs.fish.shellAliases.ls = "lsd";
  programs.fish.shellAliases.tssh = "LC_THEME=\$(cat ~/.config/current_theme) ssh -o 'SendEnv LC_THEME'";
}
