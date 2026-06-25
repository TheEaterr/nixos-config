# Base configuration for ssh configs
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    ./theme-wrapper.nix
    ./base.nix
    outputs.homeManagerModules.theme
    outputs.homeManagerModules.micro
    outputs.homeManagerModules.fish
    outputs.homeManagerModules.direnv
  ];

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    package = pkgs.nix;
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
    };
    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
  };

  programs.fish.loginShellInit = ''
    echo "Current theme: "(cat ~/.config/current_theme)
    if [ -z $LC_THEME ]
      echo "No remote theme set"
    else
      echo "Remote theme: $LC_THEME"
      if [ $LC_THEME != (cat ~/.config/current_theme) ]
        echo "Setting theme to $LC_THEME"
        toggle-theme
      end
    end
  '';

  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}
