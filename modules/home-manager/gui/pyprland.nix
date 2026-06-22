{config, ...}: {
  home.file.".config/pypr/config.toml".text = ''
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
    command = "thunderbird"
    class = "thunderbird"
    size = "90% 90%"
    lazy = false
  '';
}
