{config, ...}: {
  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;

  programs.waybar.settings = {
    mainBar = {
      name = "top_bar";
      layer = "top"; # Waybar at top layer
      position = "top"; # Waybar position (top|bottom|left|right)
      spacing = 4; # Gaps between modules (4px)
      modules-left = ["cpu#clickable" "memory#clickable" "disk#clickable" "temperature" "custom/dot" "battery" "custom/dot" "backlight" "pulseaudio#clickable" "systemd-failed-units" "hyprland/submap"];
      modules-center = ["clock"];
      modules-right = ["hyprland/workspaces" "custom/dot" "tray" "custom/dot" "privacy" "custom/recording" "custom/geo" "custom/media#clickable" "custom/dunst#clickable" "custom/night_mode#clickable" "custom/airplane_mode#clickable" "hyprland/language#clickable" "idle_inhibitor#clickable" "custom/toggle_theme#clickable" "power-profiles-daemon#clickable" "custom/dot" "custom/logout_menu#clickable"];

      "hyprland/language#clickable" = {
        format-en = "US";
        format-fr = "FR";
        keyboard-name = "at-translated-set-2-keyboard";
        on-click = "hyprctl switchxkblayout at-translated-set-2-keyboard next";
      };

      "hyprland/workspaces" = {
        format = "{name}";
        on-click = ""; # changes pointer icon on hover
      };

      "hyprland/submap" = {
        tooltip = false;
      };

      tray = {
        on-click = ""; # hack so pointer changes when hovering tray
      };

      clock = {
        format = "{:%H:%M <span color='#${config.scheme.base04}'></span> %F}";
        format-alt = "{:%H:%M}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        actions = {
          on-click-right = "mode";
        };
        calendar = {
          mode = "month";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          on-click-right = "mode";
          format = {
            months = "<span color='#${config.scheme.base0E}'><b>{}</b></span>";
            days = "<span color='#${config.scheme.base09}'><b>{}</b></span>";
            weeks = "<span color='#${config.scheme.base0C}'><b>S{}</b></span>";
            weekdays = "<span color='#${config.scheme.base0B}'><b>{}</b></span>";
            today = "<span color='#${config.scheme.base08}'><b><u>{}</u></b></span>";
          };
        };
      };

      "custom/media#clickable" = {
        format = "{icon}󰎈";
        restart-interval = 2;
        return-type = "json";
        format-icons = {
          Playing = "";
          Paused = "";
        };
        max-length = 35;
        exec = "fish -c fetch_music_player_data";
        on-click = "playerctl play-pause";
        on-click-right = "playerctl next";
        on-click-middle = "playerctl prev";
        on-scroll-up = "playerctl volume 0.05-";
        on-scroll-down = "playerctl volume 0.05+";
        smooth-scrolling-threshold = "0.1";
      };

      "custom/dot" = {
        format = "";
        tooltip = false;
      };

      # "custom/webcam = {
      #     interval = 1;
      #     exec = "fish -c check_webcam";
      #     return-type = "json";
      # };

      privacy = {
        icon-spacing = 1;
        icon-size = 12;
        transition-duration = 250;
        modules = [
          {
            type = "audio-in";
          }
          {
            type = "screenshare";
          }
        ];
      };

      "custom/recording" = {
        interval = 1;
        exec-if = "pgrep wl-screenrec";
        exec = "fish -c check_recording";
        return-type = "json";
      };

      "custom/geo" = {
        interval = 1;
        exec-if = "pgrep geoclue";
        exec = "fish -c check_geo_module";
        return-type = "json";
      };

      "custom/airplane_mode#clickable" = {
        return-type = "json";
        interval = 1;
        exec = "fish -c check_airplane_mode";
        on-click = "fish -c airplane_mode_toggle";
      };

      "custom/night_mode#clickable" = {
        return-type = "json";
        interval = 1;
        exec = "fish -c check_night_mode";
        on-click = "fish -c night_mode_toggle";
      };

      "custom/dunst#clickable" = {
        return-type = "json";
        exec = "fish -c dunst_pause";
        on-click = "dunstctl set-paused toggle";
        restart-interval = 1;
      };

      "idle_inhibitor#clickable" = {
        format = "{icon}";
        format-icons = {
          activated = "󰛐";
          deactivated = "󰛑";
        };
        tooltip-format-activated = "Idle inhibitor <span color='#${config.scheme.base0B}'>on</span>";
        tooltip-format-deactivated = "Idle inhibitor <span color='#${config.scheme.base08}'>off</span>";
        start-activated = false;
      };

      "custom/logout_menu#clickable" = {
        return-type = "json";
        exec = "echo '{ \"text\":\"󰐥\", \"tooltip\": \"Logout menu\" }'";
        interval = "once";
        on-click = "fish -c wlogout_unique";
      };

      "custom/toggle_theme#clickable" = {
        return-type = "json";
        exec =
          {
            light = "echo '{ \"text\":\"\", \"tooltip\": \"Toggle theme\" }'";
            dark = "echo '{ \"text\":\"\", \"tooltip\": \"Toggle theme\" }'";
          }
          .${config.scheme.slug};
        interval = "once";
        on-click = "toggle-theme";
      };

      "power-profiles-daemon#clickable" = {
        format = "{icon}";
        tooltip-format = "Power profile: {profile}";
        tooltip = true;
        format-icons = {
          default = "";
          performance = "";
          balanced = "";
          power-saver = "";
        };
      };

      "cpu#clickable" = {
        format = "󰻠{usage}%";
        states = {
          high = 90;
          upper-medium = 70;
          medium = 50;
          lower-medium = 30;
          low = 10;
        };
        on-click = "kitty btop";
      };

      "memory#clickable" = {
        format = "{percentage}%";
        tooltip-format = "Main: ({used} GiB/{total} GiB)({percentage}%), available {avail} GiB";
        states = {
          high = 90;
          upper-medium = 70;
          medium = 50;
          lower-medium = 30;
          low = 10;
        };
        on-click = "kitty btop";
      };

      "disk#clickable" = {
        format = "󰋊{percentage_used}%";
        tooltip-format = "({used}/{total})({percentage_used}%) in '{path}', available {free}({percentage_free}%)";
        states = {
          high = 90;
          upper-medium = 70;
          medium = 50;
          lower-medium = 30;
          low = 10;
        };
        on-click = "kitty btop";
      };

      temperature = {
        tooltip = false;
        thermal-zone = 2;
        critical-threshold = 80;
        format = "{icon}{temperatureC}󰔄";
        format-critical = "🔥{icon}{temperatureC}󰔄";
        format-icons = ["" "" "" "" ""];
      };

      battery = {
        states = {
          high = 90;
          upper-medium = 70;
          medium = 50;
          lower-medium = 30;
          low = 10;
        };
        format = "{icon}{capacity}%";
        format-charging = "󱐋{icon}{capacity}%";
        format-plugged = "󰚥{icon}{capacity}%";
        format-time = "{H} h {M} min";
        format-icons = ["󱃍" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        tooltip-format = "{timeTo}";
      };

      backlight = {
        format = "{icon}{percent}%";
        format-icons = [
          "󰌶"
          "󱩎"
          "󱩏"
          "󱩐"
          "󱩑"
          "󱩒"
          "󱩓"
          "󱩔"
          "󱩕"
          "󱩖"
          "󰛨"
        ];
        tooltip = false;
        states = {
          high = 90;
          upper-medium = 70;
          medium = 50;
          lower-medium = 30;
          low = 10;
        };
        reverse-scrolling = true;
        reverse-mouse-scrolling = true;
      };

      "pulseaudio#clickable" = {
        states = {
          high = 90;
          upper-medium = 70;
          medium = 50;
          lower-medium = 30;
          low = 10;
        };
        tooltip-format = "{desc}";
        format = "{icon}{volume}%{format_source}";
        format-bluetooth = "󰂱{icon}{volume}%{format_source}";
        format-bluetooth-muted = "󰂱󰝟{volume}%{format_source}";
        format-muted = "󰝟{volume}%{format_source}";
        format-source = "󰍬{volume}%";
        format-source-muted = "󰍭{volume}%";
        format-icons = {
          headphone = "󰋋";
          hands-free = "";
          headset = "󰋎";
          phone = "󰄜";
          portable = "󰦧";
          car = "󰄋";
          speaker = "󰓃";
          hdmi = "󰡁";
          hifi = "󰋌";
          default = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
        };
        reverse-scrolling = true;
        reverse-mouse-scrolling = true;
        on-click = "pavucontrol";
      };

      systemd-failed-units = {
        format = "✗ {nr_failed}";
      };
    };
  };

  programs.waybar.style = ''
    * {
      border: none;
    }

    window.top_bar#waybar {
      background: none;
    }

    window.top_bar .modules-center {
      background-color: #${config.scheme.base01};
      color: #${config.scheme.base06};
      border-radius: 15px;
      padding-left: 20px;
      padding-top: 2px;
      padding-right: 20px;
      border: solid 2px #${config.scheme.base09};
      margin-top: 5px;
    }

    window.top_bar .modules-left {
      background-color: #${config.scheme.base01};
      color: #${config.scheme.base06};
      border-radius: 0px 15px 15px 0px;
      padding-left: 10px;
      padding-right: 10px;
      border: solid 2px #${config.scheme.base09};
      margin-top: 5px;
      border-left: none;
    }

    window.top_bar .modules-right {
      background-color: #${config.scheme.base01};
      border-radius: 15px 0px 0px 15px;
      padding-left: 10px;
      margin-top: 5px;
      border: solid 2px #${config.scheme.base09};
      color: #${config.scheme.base06};
      border-right: none;
    }

    .module {
      border-radius: 5px;
    }

    #tray  {
      background-color: alpha(#${config.scheme.base09}, 0.6);
      margin: 3px;
      padding-left: 4px;
      padding-right: 4px;
      border-radius: 15px;
    }

    #tray .active {
      border-radius: 5px;
    }

    #tray .active:hover {
      background-color: #${config.scheme.base09};
    }

    .clickable:hover {
      background-color: alpha(#${config.scheme.base09}, 0.3);
    }

    #workspaces button.active {
      color: #${config.scheme.base09};
    }

    #workspaces button {
      color: #${config.scheme.base05};
      padding: 2px;
    }

    #workspaces button:hover {
      background: inherit;
      background-color: alpha(#${config.scheme.base09}, 0.3);
      box-shadow: inherit;
      text-shadow: inherit;
    }

    #submap {
      background-color: alpha(#${config.scheme.base09}, 0.6);
      color: #${config.scheme.base01};
      border-radius: 15px;
      padding-left: 15px;
      padding-right: 15px;
      margin-left: 10px;
      margin-top: 3px;
      margin-bottom: 3px;
    }

    #clock.time {
      color: #${config.scheme.base08};
    }

    #clock.week {
      color: #${config.scheme.base0D};
    }

    #clock.month {
      color: #${config.scheme.base0D};
    }

    #clock.calendar {
      color: #${config.scheme.base0E};
    }

    #idle_inhibitor.deactivated {
      color: #${config.scheme.base05};
    }

    #custom-dunst.off {
      color: #${config.scheme.base05};
    }

    #custom-airplane_mode.off {
      color: #${config.scheme.base05};
    }

    #custom-night_mode.off {
      color: #${config.scheme.base05};
    }

    #custom-media.Paused {
      color: #${config.scheme.base05};
    }

    #custom-webcam {
      color: #${config.scheme.base0F};
    }

    #privacy-item.screenshare {
      color: #${config.scheme.base09};
    }

    #privacy-item.audio-in {
      color: #${config.scheme.base0E};
    }

    #custom-recording {
      color: #${config.scheme.base08};
    }

    #custom-geo {
      color: #${config.scheme.base0A};
    }

    #custom-logout_menu {
      color: #${config.scheme.base08};
      padding-left: 5px;
      padding-right: 5px;
      border-radius: 20px;
    }

    #custom-dot {
      color: #${config.scheme.base04};
      padding: 0px;
    }

    #tray>.needs-attention {
      background-color: alpha(#${config.scheme.base0F}, 0.7);
      border-radius: 10px;
    }

    #cpu {
      color: #${config.scheme.base0C};
    }

    #cpu.low {
      color: #${config.scheme.base0B};
    }

    #cpu.lower-medium {
      color: #${config.scheme.base0A};
    }

    #cpu.medium {
      color: #${config.scheme.base09};
    }

    #cpu.upper-medium {
      color: #${config.scheme.base0F};
    }

    #cpu.high {
      color: #${config.scheme.base08};
    }

    #memory {
      color: #${config.scheme.base0C};
    }

    #memory.low {
      color: #${config.scheme.base0B};
    }

    #memory.lower-medium {
      color: #${config.scheme.base0A};
    }

    #memory.medium {
      color: #${config.scheme.base09};
    }

    #memory.upper-medium {
      color: #${config.scheme.base0F};
    }

    #memory.high {
      color: #${config.scheme.base08};
    }

    #disk {
      color: #${config.scheme.base0C};
    }

    #disk.low {
      color: #${config.scheme.base0B};
    }

    #disk.lower-medium {
      color: #${config.scheme.base0A};
    }

    #disk.medium {
      color: #${config.scheme.base09};
    }

    #disk.upper-medium {
      color: #${config.scheme.base0F};
    }

    #disk.high {
      color: #${config.scheme.base08};
    }

    #temperature {
      color: #${config.scheme.base0B};
    }

    #temperature.critical {
      color: #${config.scheme.base08};
    }

    #battery {
      color: #${config.scheme.base0C};
    }

    #battery.low {
      color: #${config.scheme.base08};
    }

    #battery.lower-medium {
      color: #${config.scheme.base0F};
    }

    #battery.medium {
      color: #${config.scheme.base09};
    }

    #battery.upper-medium {
      color: #${config.scheme.base0A};
    }

    #battery.high {
      color: #${config.scheme.base0B};
    }

    #backlight {
      color: #${config.scheme.base05};
    }

    #backlight.low {
      color: #${config.scheme.base05};
    }

    #backlight.lower-medium {
      color: #${config.scheme.base07};
    }

    #backlight.medium {
      color: #${config.scheme.base07};
    }

    #backlight.upper-medium {
      color: #${config.scheme.base06};
    }

    #backlight.high {
      color: #${config.scheme.base06};
    }

    #pulseaudio {
      color: #${config.scheme.base06};
    }

    #pulseaudio.low {
      color: #${config.scheme.base05};
    }

    #pulseaudio.lower-medium {
      color: #${config.scheme.base05};
    }

    #pulseaudio.medium {
      color: #${config.scheme.base07};
    }

    #pulseaudio.upper-medium {
      color: #${config.scheme.base07};
    }

    #pulseaudio.high {
      color: #${config.scheme.base06};
    }

    #pulseaudio.bluetooth {
      color: #${config.scheme.base0C};
    }

    #pulseaudio.muted {
      color: #${config.scheme.base02};
    }

    #systemd-failed-units {
      color: #${config.scheme.base08};
    }
  '';
}
