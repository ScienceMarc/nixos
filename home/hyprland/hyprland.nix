{ pkgs, inputs, config, ... }: {
    #hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;

    imports = [
        ./waybar.nix
        ./hyprlock.nix
        ./hypridle.nix
    ];

    home.packages = with pkgs; [
        waybar # Bar
        swaynotificationcenter # Notif daemon
        libnotify # Needed by swaync
        foot # Terminal
        anyrun # App launcher
        #cinnamon.nemo # 

        hyprpaper # Wallpaper
        hyprshot # Screenshot
        hyprpicker # Color picker
        hyprlock # Lock screen
        hypridle # Idle daemon
        nwg-look # Cursor
        # nwg-displays # Display config

        networkmanagerapplet # Wifi
        blueman # Bluetooth
        brightnessctl # Brightness keys
        lxqt.lxqt-policykit # polkit
        playerctl # Deal with media keys
    ];

    # home.sessionVariables = {
    #     "NIXOS_OZONE_WL" = "1";
    #     "ELECTRON_OZONE_PLATFORM_HINT" = "auto";
    # };

    programs.foot = {
        enable = true;
        settings = {
            main = {
                font = "monospace:size=11";
            };
        };
    };

    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            autogenerated = "0";
            
            misc = {
                # This really should be default imo
                # It's confusing otherwise
                new_window_takes_over_fullscreen = 2;
            };

            ### MONITOR CONFIG ###
            # monitor = ",preferred,1920x1080@144,1";
            monitor = [
                "eDP-1, preferred, auto, 1.33"
            ];

            # Start up extra components
            exec-once = [
                #"waybar & dunst & libnotify & hyperpaper & nm-applet & blueman-applet"
                "swaync & libnotify & hyperpaper & nm-applet & blueman-applet"
                "lxqt-policykit-agent"
                # "[workspace 1 silent] firefox"
                # "[workspace 2 silent] discord"
                # "[workspace 2 silent] telegram-desktop"
                # "[workspace 3 silent] code"
                # "[workspace 4 silent] kitty btop"
                # "[workspace 4 silent] thunderbird"
            ];

            # Definitions
            "$mainMod" = "SUPER";

            input = {
                kb_layout = "us";

                touchpad = {
                    natural_scroll = "yes";
                    disable_while_typing = false;
                };

                sensitivity = "0";
                numlock_by_default = true;
            };

            xwayland = {
                #force_zero_scaling = "true";
            };

            general = {
                gaps_in = "2";
                gaps_out = "10";
                border_size = "2";
                "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
                "col.inactive_border" = "rgba(595959aa)";

                layout = "dwindle";

                # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
                allow_tearing = false;
            };

            decoration = {
                rounding = 5;
            };

            gestures = {
                workspace_swipe = true;
                workspace_swipe_fingers = 3;
            };

            animations = {
                enabled = "yes";
                animation = [
                    "workspaces,1,1,default"
                ];
            };

            dwindle = {
                smart_split = true;
                # no_gaps_when_only = 1;
            };

            bind = [
                #"$mainMod, W, exec, nm-applet"
                #"$mainMod, B, exec, blueman-applet"

                "$mainMod, C, exec, foot"
                "$mainMod, Q, killactive, "
                # "$mainMod, M, exit, "
                "$mainMod, E, exec, dolphin"
                "$mainMod, V, togglefloating, "
                "ALT, Space, exec, anyrun"
                "$mainMod, P, pseudo, # dwindle"
                "$mainMod, J, togglesplit, # dwindle"

                "$mainMod, L, exec, hyprlock"
                "$mainMod, N, exec, swaync-client -t"

                "$mainMod SHIFT, F, exec, firefox"
                "$mainMod SHIFT, P, exec, firefox --private-window"
                "$mainMod SHIFT, N, exec, firefox -P Second_user"
                "$mainMod SHIFT, C, exec, code"
                

                # Screenshotting
                ", Print, exec, hyprshot -m region --clipboard-only"
                "SHIFT, Print, exec, hyprshot -m output --clipboard-only"

                # Move focus with mainMod + arrow keys
                "$mainMod, left, movefocus, l"
                "$mainMod, right, movefocus, r"
                "$mainMod, up, movefocus, u"
                "$mainMod, down, movefocus, d"

                # Shift the tiles around
                "$mainMod ALT, right, movewindow, r"
                "$mainMod ALT, left, movewindow, l"
                "$mainMod ALT, up, movewindow, u"
                "$mainMod ALT, down, movewindow, d"

                "$mainMod, F, fullscreen, 1"
                "ALT, Tab, cyclenext,"
                "$mainMod, Tab, workspace, e+1"
                "$mainMod SHIFT, Tab, workspace, e-1"

                # Switch workspaces with mainMod + [0-9]
                "$mainMod, 1, workspace, 1"
                "$mainMod, 2, workspace, 2"
                "$mainMod, 3, workspace, 3"
                "$mainMod, 4, workspace, 4"
                "$mainMod, 5, workspace, 5"
                "$mainMod, 6, workspace, 6"
                "$mainMod, 7, workspace, 7"
                "$mainMod, 8, workspace, 8"
                "$mainMod, 9, workspace, 9"
                "$mainMod, 0, workspace, 10"

                # Move active window to a workspace with mainMod + SHIFT + [0-9]"
                "$mainMod SHIFT, 1, movetoworkspace, 1"
                "$mainMod SHIFT, 2, movetoworkspace, 2"
                "$mainMod SHIFT, 3, movetoworkspace, 3"
                "$mainMod SHIFT, 4, movetoworkspace, 4"
                "$mainMod SHIFT, 5, movetoworkspace, 5"
                "$mainMod SHIFT, 6, movetoworkspace, 6"
                "$mainMod SHIFT, 7, movetoworkspace, 7"
                "$mainMod SHIFT, 8, movetoworkspace, 8"
                "$mainMod SHIFT, 9, movetoworkspace, 9"
                "$mainMod SHIFT, 0, movetoworkspace, 10"

                # Special workspace
                "$mainMod SHIFT, Z, movetoworkspace, special"
                "$mainMod, Z, togglespecialworkspace,"
            ];

            bindm = [
                # Move/resize windows with mainMod + LMB/RMB and dragging"
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
            ];

            bindl = [
                ",switch:on:Lid Switch,exec,hyprlock"

                # Media keys
                ",XF86AudioPrev, exec, playerctl previous"
                ",XF86AudioNext, exec, playerctl next"
                ",XF86AudioPlay, exec, playerctl play-pause"
            ];
            
            binde = [
                # Brightness
                ",code:233, exec, brightnessctl set 5%+"
                ",code:232, exec, brightnessctl set 5%-"

                # Volume
                ",code:123, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+"
                ",code:122, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-"
                ",code:121, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 0%"

                # Resize tiles
                "$mainMod SHIFT, right, resizeactive, 15 0"
                "$mainMod SHIFT, left, resizeactive, -15 0"
                "$mainMod SHIFT, up, resizeactive, 0 -15"
                "$mainMod SHIFT, down, resizeactive, 0 15"
            ];
        };
    };
}
