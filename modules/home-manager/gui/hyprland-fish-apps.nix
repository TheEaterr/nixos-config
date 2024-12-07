{...}: {
  programs.fish.enable = true;

  programs.fish.functions = {
    airplane_mode_toggle = ''
      set backup_file ~/.cache/airplane_backup

      if test -e $backup_file
          # Read network states from the backup file
          set -l wifi_status (cat $backup_file | grep -o 'wifi:\(on\|off\)$' | cut -d':' -f2)
          set -l bluetooth_status (cat $backup_file | grep -o 'bluetooth:\(on\|off\)$' | cut -d':' -f2)

          # Restore network states
          if test "$wifi_status" = "on"
              nmcli radio wifi on
          # else
          #     nmcli radio wifi off
          end

          if test "$bluetooth_status" = "on"
              rfkill unblock bluetooth
          # else
          #     rfkill block bluetooth
          end

          # Remove the backup file
          rm $backup_file
      else
          # Backup the current network states and turn off all networks
          echo "wifi:$(rfkill list wifi | grep -q "Soft blocked: no" && echo "on" || echo "off")" > $backup_file
          echo "bluetooth:$(rfkill list bluetooth | grep -qi "Soft blocked: no" && echo "on" || echo "off")" >> $backup_file
          # Add more lines to backup other network types if needed

          nmcli radio wifi off
          rfkill block bluetooth
      end
    '';

    autostart = "pypr & waybar & poweralertd & wl-paste --type text --watch cliphist store & wl-paste --type image --watch cliphist store & wl-clip-persist --clipboard regular & systemctl --user start psi-notify";

    bookmark_add = ''
      if [ -z $(wl-paste) ]
        dunstify "Bookmarks" "Can`t add empty space" -u critical -t 2000
      else if grep -q "^$(wl-paste)\$" .bookmarks
        dunstify "Bookmarks" "Bookmark '$(wl-paste)' already exists" -u critical -t 2000
      else
        wl-paste >> .bookmarks;
        dunstify "Bookmarks" "Bookmark '$(wl-paste)' was added" -t 2000
      end
    '';

    bookmark_delete = ''
      set bookmark $(cat .bookmarks | rofi -dmenu -p 'delete bookmark')
      if not [ -z $bookmark ]
        sed -i -e /$bookmark/d .bookmarks
        dunstify "Bookmarks" "Bookmark '$bookmark' was deleted" -t 2000
      end
    '';

    bookmark_to_launch = ''
      set bookmark $(cat .bookmarks | rofi -dmenu -p 'launch bookmark' | tr -d '\n')
      xdg-open $bookmark
    '';

    bookmark_to_type = "cat .bookmarks | rofi -dmenu -p 'type bookmark' | tr -d '\n' | wtype -";

    check_airplane_mode = ''
      set backup_file ~/.cache/airplane_backup

      if test -e $backup_file
        echo "{ \"text\":\"󰀝\", \"tooltip\": \"Airplane mode <span color='#a6da95'>on</span>\", \"class\": \"on\" }"
      else
        echo "{ \"text\":\"󰀞\", \"tooltip\": \"Airplane mode <span color='#ee99a0'>off</span>\", \"class\": \"off\" }"
      end
    '';

    check_geo_module = ''
      set target_process "geoclue"

      if pgrep $target_process > /dev/null
        echo "{\"text\":\"󰆤\", \"tooltip\":\"Geopositioning\", \"alt\":\"Geo\"}"
      end
    '';

    check_night_mode = ''
      set target_process "gammastep"

      if pgrep $target_process > /dev/null
        echo "{ \"text\":\"󱩌\", \"tooltip\": \"Night mode <span color='#a6da95'>on</span>\", \"class\": \"on\" }"
      else
        echo "{ \"text\":\"󱩍\", \"tooltip\": \"Night mode <span color='#ee99a0'>off</span>\", \"class\": \"off\" }"
      end
    '';

    check_recording = ''
      set target_process wl-screenrec

      if pgrep $target_process >/dev/null
        echo "{\"text\":\"\", \"tooltip\":\"Recording\", \"alt\":\"Recording\"}"
      end
    '';

    clipboard_clear = ''
      rm "$HOME/.cache/cliphist/db"
      dunstify Clipboard Cleared -t 2000
    '';

    clipboard_delete_item = ''
      set clip $(cliphist list | rofi -dmenu -p 'clipboard delete item')
      if not [ -z $clip ]
        echo $clip | cliphist delete
        dunstify "Clipboard" "Clip '$clip' was deleted" -t 2000
      end
    '';

    clipboard_to_wlcopy = ''
      set clip $(cliphist list | rofi -dmenu -p 'clipboard copy')
      if not [ -z $clip ]
        echo $clip | cliphist decode | wl-copy
        dunstify "Clipboard" "Clip '$clip' was copied" -t 2000
      end
    '';

    dunst_pause = ''
      set COUNT_WAITING (dunstctl count waiting)
      set COUNT_DISPLAYED (dunstctl count displayed)
      set ENABLED "{ \"text\": \"󰂜\", \"tooltip\": \"Notifications <span color='#a6da95'>on</span>\", \"class\": \"on\" }"
      set DISABLED "{ \"text\": \"󰪑\", \"tooltip\": \"Notifications <span color='#ee99a0'>off</span>\", \"class\": \"off\" }"

      if [ $COUNT_DISPLAYED != 0 ]
        set ENABLED "{ \"text\": \"󰂚$COUNT_DISPLAYED\", \"tooltip\": \"$COUNT_DISPLAYED notifications\", \"class\": \"on\" }"
      end

      if [ $COUNT_WAITING != 0 ]
        set DISABLED "{ \"text\": \"󰂛$COUNT_WAITING\", \"tooltip\": \"(silent) $COUNT_WAITING notifications\", \"class\": \"off\" }"
      end

      if dunstctl is-paused | rg -q "false"
        echo $ENABLED
      else
        echo $DISABLED
      end
    '';

    fetch_music_player_data = ''
      playerctl -a metadata --format "{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"<i><span color='#a6da95'>{{playerName}}</span></i>: <b><span color='#f5a97f'>{{artist}}</span> - <span color='#c6a0f6'>{{markup_escape(title)}}</span></b>\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}" -F
    '';

    night_mode_toggle = ''
      set target_process "gammastep"

      if pgrep $target_process > /dev/null
        killall -s SIGINT .gammastep-wrap
      else
        gammastep
      end
    '';

    record_screen_gif = ''
      set target_process wl-screenrec

      if pgrep $target_process >/dev/null
        killall -s SIGINT $target_process
      else
        set geometry (slurp)
        if not [ -z $geometry ]
          set record_name $(echo "record-$(date +"%Y-%m-%d--%H:%M:%S")")
          dunstify -r $(cd ~/Pictures/Records/ && ls -1 | wc -l) "Recording Started  (GIF)" -t 2000
          wl-screenrec -g "$geometry" -f "$HOME/Pictures/Records/$record_name.mp4" --encode-resolution 1920x1080
          ffmpeg -i "$HOME/Pictures/Records/$record_name.mp4" "$HOME/Pictures/Records/$record_name.gif"
          rm "$HOME/Pictures/Records/$record_name.mp4"
          wl-copy -t text/uri-list file://$HOME/Pictures/Records/$record_name.gif\n
          dunstify -r $(cd ~/Pictures/Records/ && ls -1 | wc -l) "Recording Stopped 󰙧 (GIF)" -t 2000
        end
      end
    '';

    record_screen_mp4 = ''
      set target_process wl-screenrec

      if pgrep $target_process >/dev/null
        killall -s SIGINT $target_process
      else
        set geometry (slurp)
        if not [ -z $geometry ]
          set record_name $(echo "record-$(date +"%Y-%m-%d--%H:%M:%S")")
          dunstify -r $(cd ~/Videos/Records/ && ls -1 | wc -l) "Recording Started  (MP4)" -t 2000
          wl-screenrec -g "$geometry" -f "$HOME/Videos/Records/$record_name.mp4"
          wl-copy -t text/uri-list file://$HOME/Videos/Records/$record_name.mp4\n
          dunstify -r $(cd ~/Videos/Records/ && ls -1 | wc -l) "Recording Stopped 󰙧 (MP4)" -t 2000
        end
      end
    '';

    screenshot_edit = "swappy -f ~/Pictures/Screenshots/(cd ~/Pictures/Screenshots && ls -tA | head -n1 | awk '{print $1}')";

    screenshot_to_clipboard = ''
      if [ $(ps -u | grep "fish -c screenshot_to_clipboard" | grep tty | wc -l) = 2 ]
        set screenshot_filename (echo "$HOME/Pictures/Screenshots/screenshot-$(date +"%Y-%m-%d--%H:%M:%S").png")
        grim -g (slurp) $screenshot_filename

        if [ -e $screenshot_filename ]
          cat $screenshot_filename | wl-copy --type image/png
          dunstify -i $screenshot_filename -r (cd ~/Pictures/Screenshots/ && ls -1 | wc -l) "Screenshots" "Screenshot was taken" -t 2000
        end
      end
    '';

    wlogout_unique = ''
      if [ -z $(pidof wlogout) ]
        wlogout -b 2
      end
    '';
  };
}
