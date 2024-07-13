{
  config,
  themeParams,
  ...
}: {
  home.file.".config/rofi/config.rasi".text = ''
    configuration{
      modes: "window,drun,run,filebrowser";
      font: "JetBrains Mono Regular 13";
      show-icons: true;
      terminal: "kitty";
      drun-display-format: "{icon} {name}";
      location: 0;
      disable-history: false;
      hide-scrollbar: false;
      display-drun: "apps";
      filebrowser {
        /** Directory the file browser starts in. */
        directory: "/home/eaterr";
        show-hidden: true;
      }
    }

    @theme "~/.config/rofi/theme.rofi"
  '';

  home.file.".config/rofi/theme.rofi".text = ''
    * {
        red:                         #${config.scheme.base08};
        selected-active-foreground:  #${config.scheme.base02};
        separatorcolor:              transparent;
        urgent-foreground:           rgba ( 204, 102, 102, 100 % );
        background-color:            transparent;
        border-color:                #${config.base16Accent};
        normal-background:           var(background);
        selected-urgent-background:  rgba ( 165, 66, 66, 100 % );
        spacing:                     2;
        blue:                        #${config.scheme.base0D};
        urgent-background:           var(background);
        selected-normal-foreground:  #${config.scheme.base02};
        active-foreground:           #${config.base16Accent};
        background:                  #${config.scheme.base01}ee;
        selected-normal-background:  #${config.base16Accent};
        selected-active-background:  #${config.base16Accent};
        active-background:           #${config.scheme.base01}ee;
        foreground:                  #${config.base16Accent};
        selected-urgent-foreground:  #${config.scheme.base02};
        normal-foreground:           var(foreground);
    }
    window {
        padding:          5;
        background-color: var(background);
        border:           2;
        border-radius: 15;
    }
    mainbox {
        padding: 0;
        border:  0;
    }
    message {
        padding:      1px ;
        border-color: var(separatorcolor);
        border:       2px 0px 0px ;
    }
    textbox {
        text-color: var(foreground);
    }
    listview {
        padding:      2px 0px 0px ;
        scrollbar:    true;
        border-color: var(separatorcolor);
        spacing:      2px ;
        fixed-height: 0;
        border:       2px 0px 0px ;
    }
    element {
        padding: 1px ;
        border:  0;
        border-radius: 15;
    }
    element normal {
        text-color:       var(normal-foreground);
    }
    element urgent {
        background-color: var(urgent-background);
        text-color:       var(urgent-foreground);
    }
    element active {
        background-color: var(active-background);
        text-color:       var(active-foreground);
    }
    element selected.normal {
        background-color: var(selected-normal-background);
        text-color:       var(selected-normal-foreground);
    }
    element selected.urgent {
        background-color: var(selected-urgent-background);
        text-color:       var(selected-urgent-foreground);
    }
    element selected.active {
        background-color: var(selected-active-background);
        text-color:       var(selected-active-foreground);
    }
    element-text {
        background-color: inherit;
        text-color:       inherit;
    }
    scrollbar {
        width:        4px ;
        padding:      0;
        handle-width: 8px ;
        border:       0;
        handle-color: var(normal-foreground);
    }
    mode-switcher {
        border-color: var(separatorcolor);
        border:       2px 0px 0px ;
        border-radius: 15;
    }
    button {
        spacing:    0;
        text-color: var(normal-foreground);
    }
    button selected {
        background-color: var(selected-normal-background);
        text-color:       var(selected-normal-foreground);
    }
    inputbar {
        padding:    1px ;
        spacing:    0;
        text-color: var(normal-foreground);
        children:   [ "prompt","textbox-prompt-colon","entry","case-indicator" ];
    }
    case-indicator {
        spacing:    0;
        text-color: var(normal-foreground);
    }
    entry {
        spacing:    0;
        text-color: var(normal-foreground);
    }
    prompt {
        spacing:    0;
        text-color: var(normal-foreground);
    }
    textbox-prompt-colon {
        margin:     0px 0.3000em 0.0000em 0.0000em ;
        expand:     false;
        str:        ":";
        text-color: var(normal-foreground);
    }
  '';
}
