{config, ...}: {
  home.file.".config/wlogout/style.css".text = ''
    * {
      background-image: none;
    }

    window {
      background-color: rgba(40, 40, 40, 0.6);
    }

    button {
      margin: 8px;
      color: #${config.colorScheme.palette.base07};
      font-size: 16px;
      font-weight: bold;
      background-color: #${config.colorScheme.palette.base01};
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
      border: solid 5px #${config.colorScheme.palette.base09};
      outline-style: none;
    }

    #logout {
      background-image: image(url("icons/logout.png"));
    }

    #suspend {
      background-image: image(url("icons/suspend.png"));
    }

    #shutdown {
      background-image: image(url("icons/shutdown.png"));
    }

    #reboot {
      background-image: image(url("icons/reboot.png"));
    }
  '';
}
