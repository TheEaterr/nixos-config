{config, ...}: {
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
        path = $HOME/lockscreen_3x2.png
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

    # # USER AVATAR
    # image {
    #     monitor =
    #     path = $HOME/.face
    #     size = 350
    #     border_color = $accent
    #     rounding = -1

    #     position = 0, 75
    #     halign = center
    #     valign = center
    #     shadow_passes = 2
    # }

    # INPUT FIELD
    input-field {
        monitor =
        size = 200, 50
        outline_thickness = 3
        dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = false
        dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
        outer_color = rgba(44,44,44)
        inner_color = rgb( 239, 239, 239)
        font_color = rgb(10, 10, 10)
        font_family = $font
        fade_on_empty = false
        fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
        # placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
        placeholder_text = <span foreground="##2C2C2C" style="italic">Input Password...</span>
        hide_input = false
        rounding = 15 # -1 means complete rounding (circle/oval)
        check_color = rgb(251, 140, 0)
        fail_color = rgb(204, 34, 34) # if authentication failed, changes outer_color and fail message color
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
