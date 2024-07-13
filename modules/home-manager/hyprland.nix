{
  config,
  themeParams,
  ...
}: let
  avizoFlag =
    {
      light = "";
      dark = "-d";
    }
    .${
      config
      .scheme
      .variant
    };
in {
  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.extraConfig = ''
    #
    # Please note not all available settings / options are set here.
    # For a full list, see the wiki
    #

    #autogenerated = 1 # remove this line to remove the warning

    # See https://wiki.hyprland.org/Configuring/Monitors/
    monitor=eDP-1,2256x1504,0x1080,1.333333
    monitor=,preferred,0x0,1


    # See https://wiki.hyprland.org/Configuring/Keywords/ for more

    # Execute your favorite apps at launch
    exec-once = fish -c autostart
    # Restore previous brightness setting
    exec-once=light -I
    exec-once=nm-applet --indicator
    exec-once=blueman-applet
    exec-once=sleep 2 && nextcloud --background
    exec-once=signal-desktop --start-in-tray

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = fr,us
        kb_variant = oss,
        kb_model =
        kb_options = grp:alt_shift_toggle
        kb_rules =

        follow_mouse = 1

        touchpad {
            natural_scroll = yes
            tap-and-drag = true
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }

    # XWayland disable scaling
    xwayland {
        force_zero_scaling = true
    }
    # env = GDK_SCALE, 1.4

    env = QT_QPA_PLATFORM,wayland
    env = QT_STYLE_OVERRIDE,kvantum
    env = HYPRCURSOR_SIZE,32

    general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 2.5
        gaps_out = 5
        border_size = 2
        col.active_border = rgb(${config.base16Accent})

        layout = dwindle
    }

    decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        rounding = 15

        blur {
            size = 8
            passes = 2
        }
    }

    # layerrule = blur, waybar

    animations {
        enabled = yes

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = myBezier, 0.05, 0.9, 0.1, 1.05

        animation = windows, 1, 2, myBezier
        animation = windowsOut, 1, 2, default, popin 80%
        animation = border, 1, 3, default
        animation = fade, 1, 2, default
        animation = workspaces, 1, 1, default
    }

    dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes
    }

    gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = on
    }

    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        background_color = 0x24273a
        initial_workspace_tracking = 0
        enable_swallow = true
        swallow_regex = ^(kitty)$
        focus_on_activate = true
        middle_click_paste = false
    }

    binds {
        workspace_back_and_forth = true
        workspace_center_on = 1
    }

    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
    # device {
    #     name = epic mouse V1
    #     sensitivity = -0.5
    # }

    # Example windowrule v1
    windowrule = opacity 0.7 0.7 0.7, ^(kitty)$
    windowrule = float, imv
    windowrule = center 1, swappy
    windowrule = stayfocused, swappy
    # windowrule = size 50% 50%, mpv
    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

    # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    $mainMod = SUPER

    # will switch to a submap called resize
    bind=$mainMod, R,submap,resize

    # will start a submap called "resize"
    submap=resize

    # sets repeatable binds for resizing the active window
    binde=,l,resizeactive,10 0
    binde=,h,resizeactive,-10 0
    binde=,k,resizeactive,0 -10
    binde=,j,resizeactive,0 10

    # use reset to go back to the global submap
    bind=,escape,submap,reset

    # will reset the submap, meaning end the current one and return to the global one
    submap=reset

    # sets repeatable binds for moving the active window
    bind=$mainMod SHIFT,l,movewindow,r
    bind=$mainMod SHIFT,h,movewindow,l
    bind=$mainMod SHIFT,k,movewindow,u
    bind=$mainMod SHIFT,j,movewindow,d

    # keybinds further down will be global again...

    # Scrachpads
    bind = $mainMod CTRL, T, exec, pypr toggle term
    windowrulev2 = opacity 0.7 0.7 0.7,class:(kitty-dropterm)

    bind = $mainMod, T, exec, kitty
    # bind = $mainMod CTRL, E, exec, pypr expose
    bind = $mainMod, Z, exec, pypr zoom

    bind = $mainMod, B, exec, firefox
    bind = $mainMod, F, exec, thunar
    bind = $mainMod, D, exec, rofi -show drun
    bind = $mainMod SHIFT, D, exec, rofi -show filebrowser
    bind = $mainMod SHIFT, R, exec, rofi -show run
    bind = $mainMod, W, exec, rofi -show window
    bind = $mainMod, ESCAPE, exec, fish -c wlogout_unique
    bind = $mainMod ALT, L, exec, hyprlock
    bind = $mainMod SHIFT, S, exec, fish -c screenshot_to_clipboard
    bind = $mainMod, E, exec, fish -c screenshot_edit
    bind = $mainMod ALT, R, exec, fish -c record_screen_mp4
    bind = $mainMod, V, exec, fish -c clipboard_to_wlcopy
    bind = $mainMod, X, exec, fish -c clipboard_delete_item
    bind = $mainMod SHIFT, X, exec, fish -c clipboard_clear
    bind = $mainMod ALT, U, exec, fish -c bookmark_to_type
    bind = $mainMod SHIFT, U, exec, fish -c bookmark_add
    bind = $mainMod CTRL, U, exec, fish -c bookmark_delete
    bind = $mainMod, U, exec, fish -c bookmark_to_launch
    bind = $mainMod, C, exec, hyprpicker -a
    bind = $mainMod SHIFT, Q, killactive
    bind = $mainMod SHIFT, F, togglefloating,
    bind = $mainMod CTRL, F, fullscreen, 0
    bind = $mainMod , P, exec, wlrlui
    bind = $mainMod SHIFT, O, togglesplit, # dwindle
    bind = $mainMod ALT, M, exit,
    bind = $mainMod, N, exec, toggle-theme-gui

    bind = , XF86RFKill, exec, fish -c airplane_mode_toggle
    bind = $mainMod SHIFT, N, exec, dunstctl set-paused toggle
    bind = $mainMod SHIFT, Y, exec, fish -c bluetooth_toggle
    # bind = $mainMod SHIFT, W, exec, fish -c wifi_toggle

    bind = , XF86AudioPlay , exec, playerctl play-pause
    bind = , XF86AudioNext, exec, playerctl next
    bind = , XF86AudioPrev, exec, playerctl previous

    bind = , XF86AudioRaiseVolume, exec, volumectl ${avizoFlag} -u up
    bind = , XF86AudioLowerVolume, exec, volumectl ${avizoFlag} -u down
    bind = , XF86AudioMute, exec, volumectl ${avizoFlag} toggle-mute
    bind = , XF86AudioMicMute, exec, volumectl ${avizoFlag} -m toggle-mute

    # Change and save brightness setting, ${avizoFlag} toggles
    # dark mode icons
    bind = , XF86MonBrightnessUp, exec, lightctl ${avizoFlag} up && light -O
    bind = , XF86MonBrightnessDown, exec, lightctl ${avizoFlag} down && light -O

    # Move focus with mainMod + arrow keys
    bind = $mainMod, h, movefocus, l
    bind = $mainMod, l, movefocus, r
    bind = $mainMod, k, movefocus, u
    bind = $mainMod, j, movefocus, d
    bind = $mainMod, Tab, cyclenext,
    bind = $mainMod, Tab, bringactivetotop,

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, ampersand, workspace, 1
    bind = $mainMod, eacute, workspace, 2
    bind = $mainMod, quotedbl, workspace, 3
    bind = $mainMod, apostrophe, workspace, 4
    bind = $mainMod, parenleft, workspace, 5
    bind = $mainMod, minus, workspace, 6
    bind = $mainMod, egrave, workspace, 7
    bind = $mainMod, underscore, workspace, 8
    bind = $mainMod, ccedilla, workspace, 9
    bind = $mainMod, agrave, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, ampersand, movetoworkspace, 1
    bind = $mainMod SHIFT, eacute,  movetoworkspace, 2
    bind = $mainMod SHIFT, quotedbl, movetoworkspace, 3
    bind = $mainMod SHIFT, apostrophe, movetoworkspace, 4
    bind = $mainMod SHIFT, parenleft, movetoworkspace, 5
    bind = $mainMod SHIFT, minus,  movetoworkspace, 6
    bind = $mainMod SHIFT, egrave,  movetoworkspace, 7
    bind = $mainMod SHIFT, underscore, movetoworkspace, 8
    bind = $mainMod SHIFT, ccedilla, movetoworkspace, 9
    bind = $mainMod SHIFT, agrave,  movetoworkspace, 10

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
  '';
}
