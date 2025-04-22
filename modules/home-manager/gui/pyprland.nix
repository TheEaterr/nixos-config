{config, ...}: {
  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
        "scratchpads",
        "magnify",
    ]

    [scratchpads.term]
    animation = "fromTop"
    command = "kitty --class kitty-dropterm"
    class = "kitty-dropterm"
    size = "75% 60%"

    [scratchpads.thunderbird]
    animation = "fromBottom"
    command = "thunderbird --class thunderbird-drop"
    class = "thunderbird-drop"
    size = "90% 90%"
  '';
}
