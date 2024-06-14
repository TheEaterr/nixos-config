{
  config,
  inputs,
  ...
}: {
  services.hypridle.enable = true;

  services.hypridle.settings = {
    general = {
      lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
      before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
      after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
    };

    listener = [
      {
        timeout = 180; # 3min.
        on-timeout = "light -O && light -S 1%"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
        on-resume = "light -I"; # monitor backlight restore.
      }

      {
        timeout = 300; # 5min
        on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
      }

      {
        timeout = 350; # 5.83min
        on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
        on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
      }

      {
        timeout = 420; # 7min
        on-timeout = "systemctl suspend"; # suspend pc
      }
    ];
  };
}
