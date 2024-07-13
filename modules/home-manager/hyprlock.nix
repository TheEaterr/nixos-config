{
  config,
  outputs,
  themeParams,
  ...
}: {
  programs.hyprlock.enable = true;
  programs.hyprlock.extraConfig = ''
    $font = JetBrains Mono Regular

    # GENERAL
    general {
        disable_loading_bar = true
        hide_cursor = true
    }

    # BACKGROUND
    background {
        monitor =
        path = ${outputs.assets.lockscreen_3x2}
    }

    # TIME
    label {
        monitor =
        text = cmd[update:30000] echo "$(date +"%R")"
        font_size = 90
        font_family = $font
        position = -130, -100
        halign = right
        valign = top
        shadow_passes = 2
    }

    # DATE
    label {
        monitor =
        text = cmd[update:43200000] echo "$(date +"%A, %d %B %Y")"
        font_size = 25
        font_family = $font
        position = -130, -250
        halign = right
        valign = top
        shadow_passes = 2
    }

    # KEYBOARD LAYOUT
    label {
        monitor =
        text = $LAYOUT
        font_size = 20
        font_family = $font
        rotate = 0 # degrees, counter-clockwise

        position = -130, -310
        halign = right
        valign = top
        shadow_passes = 2
    }

    # USER AVATAR
    image {
        monitor =
        path = ${outputs.assets.profile}
        size = 200
        border_color = rgb(${config.scheme.base01-rgb-r}, ${config.scheme.base01-rgb-g}, ${config.scheme.base01-rgb-b})
        rounding = -1

        position = 0, 75
        halign = center
        valign = center
        shadow_passes = 2
    }

    # INPUT FIELD
    input-field {
        monitor =
        size = 200, 50
        outline_thickness = 3
        dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = false
        dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
        outer_color = rgb(${config.scheme.base01-rgb-r}, ${config.scheme.base01-rgb-g}, ${config.scheme.base01-rgb-b})
        inner_color = rgb(${config.scheme.base01-rgb-r}, ${config.scheme.base01-rgb-g}, ${config.scheme.base01-rgb-b})

        fade_on_empty = false
        fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.

        placeholder_text = <span foreground="##${config.scheme.base05}" style="italic">Input Password...</span>
        hide_input = false
        rounding = 15 # -1 means complete rounding (circle/oval)
        check_color = #${config.base16Accent}
        fail_color = #${config.scheme.base08} # if authentication failed, changes outer_color and fail message color
        fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
        fail_transition = 300 # transition time in ms between normal outer_color and fail_color
        capslock_color = -1
        numlock_color = -1
        bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
        invert_numlock = false # change color if numlock is off
        swap_font_color = false # see below

        position = 0, -150
        halign = center
        valign = center
    }
  '';
}
