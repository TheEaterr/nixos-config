{
  config,
  inputs,
  ...
}: {
  programs.kitty.enable = true;
  programs.kitty.catppuccin.enable = true;

  programs.kitty.settings = {
    confirm_os_window_close = 0;
    clipboard_control = "write-clipboard write-primary read-clipboard read-primary";
  };

  programs.kitty.font.name = "JetBrains Mono NL Bold";
}
