{config, ...}: {
  programs.waybar.enable = true;
  programs.waybar.style = ''
    * {
      border: none;
    }

    window.top_bar#waybar {
      background: none;
    }

    window.top_bar .modules-center {
      background-color: #${config.colorScheme.palette.base01};
      color: #${config.colorScheme.palette.base07};
      border-radius: 15px;
      padding-left: 20px;
      padding-top: 2px;
      padding-right: 20px;
      border: solid 2px #${config.colorScheme.palette.base09};
      margin-top: 5px;
    }

    window.top_bar .modules-left {
      background-color: #${config.colorScheme.palette.base01};
      color: #${config.colorScheme.palette.base07};
      border-radius: 0px 15px 15px 0px;
      padding-left: 10px;
      padding-right: 10px;
      border: solid 2px #${config.colorScheme.palette.base09};
      margin-top: 5px;
      border-left: none;
    }

    window.top_bar .modules-right {
      background-color: #${config.colorScheme.palette.base01};
      border-radius: 15px 0px 0px 15px;
      padding-left: 10px;
      margin-top: 5px;
      border: solid 2px #${config.colorScheme.palette.base09};
      color: #${config.colorScheme.palette.base07};
      border-right: none;
    }

    .module {
      border-radius: 5px;
    }

    #tray .active {
      border-radius: 5px;
    }

    #tray .active:hover {
      background-color: #${config.colorScheme.palette.base00};
    }

    .clickable:hover {
      background-color: #${config.colorScheme.palette.base00};
    }

    #language {
      color: #${config.colorScheme.palette.base05};
    }

    #workspaces button.active {
      color: #${config.colorScheme.palette.base09};
    }

    #workspaces button {
      color: #${config.colorScheme.palette.base07};
      padding: 2px;
    }

    #workspaces button:hover {
      background: inherit;
      background-color: #${config.colorScheme.palette.base00};
      box-shadow: inherit;
      text-shadow: inherit;
    }

    #submap {
      background-color: alpha(#${config.colorScheme.palette.base02}, 0.7);
      border-radius: 15px;
      padding-left: 15px;
      padding-right: 15px;
      margin-left: 10px;
      margin-top: 5px;
      margin-bottom: 5px;
    }

    #clock.time {
      color: #${config.colorScheme.palette.base08};
    }

    #clock.week {
      color: #${config.colorScheme.palette.base0D};
    }

    #clock.month {
      color: #${config.colorScheme.palette.base0D};
    }

    #clock.calendar {
      color: #${config.colorScheme.palette.base0E};
    }

    #idle_inhibitor.deactivated {
      color: #${config.colorScheme.palette.base04};
    }

    #custom-dunst.off {
      color: #${config.colorScheme.palette.base04};
    }

    #custom-airplane_mode.off {
      color: #${config.colorScheme.palette.base04};
    }

    #custom-night_mode.off {
      color: #${config.colorScheme.palette.base04};
    }

    #custom-media.Paused {
      color: #${config.colorScheme.palette.base04};
    }

    #custom-webcam {
      color: #${config.colorScheme.palette.base0F};
    }

    #privacy-item.screenshare {
      color: #${config.colorScheme.palette.base09};
    }

    #privacy-item.audio-in {
      color: #${config.colorScheme.palette.base0E};
    }

    #custom-recording {
      color: #${config.colorScheme.palette.base08};
    }

    #custom-geo {
      color: #${config.colorScheme.palette.base0A};
    }

    #custom-logout_menu {
      color: #${config.colorScheme.palette.base08};
      padding-left: 5px;
      padding-right: 5px;
      border-radius: 20px;
    }

    #custom-dot {
      color: #${config.colorScheme.palette.base04};
      padding: 0px;
    }

    #tray>.needs-attention {
      background-color: alpha(#${config.colorScheme.palette.base0F}, 0.7);
      border-radius: 10px;
    }

    #cpu {
      color: #${config.colorScheme.palette.base0C};
    }

    #cpu.low {
      color: #${config.colorScheme.palette.base0B};
    }

    #cpu.lower-medium {
      color: #${config.colorScheme.palette.base0A};
    }

    #cpu.medium {
      color: #${config.colorScheme.palette.base09};
    }

    #cpu.upper-medium {
      color: #${config.colorScheme.palette.base0F};
    }

    #cpu.high {
      color: #${config.colorScheme.palette.base08};
    }

    #memory {
      color: #${config.colorScheme.palette.base0C};
    }

    #memory.low {
      color: #${config.colorScheme.palette.base0B};
    }

    #memory.lower-medium {
      color: #${config.colorScheme.palette.base0A};
    }

    #memory.medium {
      color: #${config.colorScheme.palette.base09};
    }

    #memory.upper-medium {
      color: #${config.colorScheme.palette.base0F};
    }

    #memory.high {
      color: #${config.colorScheme.palette.base08};
    }

    #disk {
      color: #${config.colorScheme.palette.base0C};
    }

    #disk.low {
      color: #${config.colorScheme.palette.base0B};
    }

    #disk.lower-medium {
      color: #${config.colorScheme.palette.base0A};
    }

    #disk.medium {
      color: #${config.colorScheme.palette.base09};
    }

    #disk.upper-medium {
      color: #${config.colorScheme.palette.base0F};
    }

    #disk.high {
      color: #${config.colorScheme.palette.base08};
    }

    #temperature {
      color: #${config.colorScheme.palette.base0B};
    }

    #temperature.critical {
      color: #${config.colorScheme.palette.base08};
    }

    #battery {
      color: #${config.colorScheme.palette.base0C};
    }

    #battery.low {
      color: #${config.colorScheme.palette.base08};
    }

    #battery.lower-medium {
      color: #${config.colorScheme.palette.base0F};
    }

    #battery.medium {
      color: #${config.colorScheme.palette.base09};
    }

    #battery.upper-medium {
      color: #${config.colorScheme.palette.base0A};
    }

    #battery.high {
      color: #${config.colorScheme.palette.base0B};
    }

    #backlight {
      color: #${config.colorScheme.palette.base02};
    }

    #backlight.low {
      color: #${config.colorScheme.palette.base03};
    }

    #backlight.lower-medium {
      color: #${config.colorScheme.palette.base04};
    }

    #backlight.medium {
      color: #${config.colorScheme.palette.base05};
    }

    #backlight.upper-medium {
      color: #${config.colorScheme.palette.base06};
    }

    #backlight.high {
      color: #${config.colorScheme.palette.base07};
    }

    #pulseaudio {
      color: #${config.colorScheme.palette.base07};
    }

    #pulseaudio.low {
      color: #${config.colorScheme.palette.base03};
    }

    #pulseaudio.lower-medium {
      color: #${config.colorScheme.palette.base04};
    }

    #pulseaudio.medium {
      color: #${config.colorScheme.palette.base05};
    }

    #pulseaudio.upper-medium {
      color: #${config.colorScheme.palette.base06};
    }

    #pulseaudio.high {
      color: #${config.colorScheme.palette.base07};
    }

    #pulseaudio.bluetooth {
      color: #${config.colorScheme.palette.base0C};
    }

    #pulseaudio.muted {
      color: #${config.colorScheme.palette.base02};
    }

    #systemd-failed-units {
      color: #${config.colorScheme.palette.base08};
    }
  '';
}
