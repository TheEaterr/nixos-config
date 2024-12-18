{
  pkgs,
  config,
  ...
}: {
  programs.fish.enable = true;
  # So fish is used in nix shell and similar
  programs.fish.interactiveShellInit = ''
    ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
    # Save the current fish_prompt function as the function _custom_old_fish_prompt.
      functions -c fish_prompt _custom_old_fish_prompt

      # With the original prompt function renamed, we can override with our own.
      function fish_prompt
          # Save the return status of the last command.
          set -l old_status $status

          # Check if file /run/.toolboxenv exists
          if test -e /run/.toolboxenv
            printf "%s%s%s" (set_color ${config.scheme.base08}) "[$CONTAINER_ID] " (set_color normal)
          end

          # Restore the return status of the previous command.
          echo "exit $old_status" | .
          # Output the original/"old" prompt.
          _custom_old_fish_prompt
      end
  '';
  programs.fish.shellAliases.ls = "lsd";
  programs.fish.shellAliases.tssh = "LC_THEME=\$(cat ~/.config/current_theme) ssh -o 'SendEnv LC_THEME'";
}
