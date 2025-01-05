{
  config,
  themeParams,
  ...
}: {
  programs.wlogout.enable = true;
  programs.wlogout.layout = [
    {
      label = "logout";
      action = "loginctl terminate-user $USER";
      text = "󰍃";
      keybind = "e";
    }
    {
      label = "shutdown";
      action = "systemctl poweroff";
      text = "󰐥";
      keybind = "s";
    }
    {
      label = "suspend";
      action = "systemctl suspend";
      text = "󰏦 ";
      keybind = "u";
    }
    {
      label = "reboot";
      action = "systemctl reboot";
      text = " ";
      keybind = "r";
    }
  ];

  programs.wlogout.style = ''
    * {
      background-image: none;
    }

    window {
      background-color: rgba(40, 40, 40, 0.6);
    }

    button {
      margin: 8px;
      color: #${config.hexAccent};
      font-size: 150px;
      padding: 50px;
      padding-left: 0px;
      padding-right: 0px;
      background-color: #${config.scheme.base02};
      background-repeat: no-repeat;
      background-position: center;
      background-size: 25%;
      box-shadow: none;
      text-shadow: none;
      border: solid 5px transparent;
      border-radius: 15px;
    }

    button:active,
    button:focus,
    button:hover {
      border: solid 5px #${config.hexAccent};
      outline-style: none;
    }
  '';
}
