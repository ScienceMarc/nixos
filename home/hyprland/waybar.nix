{config, pkgs, lib, ...}: {
    programs.waybar = {
        enable = true;
        systemd.enable = true;

        settings = [{
            height = 30;
            spacing = 4;
            layer = "top";
            position = "top";
            modules-left = [
                "hyprland/workspaces"
                "hyprland/window"
            ];

            "hyprland/workspaces" = {
                #format = "{windows}";
            };

            "hyprland/window" = {
                icon = true;
            };

            modules-right = [
                "power-profiles-daemon"
                "backlight"
                "temperature"
                "cpu"
                "memory"
                "pulseaudio"
                "network"
                "battery"
                "clock"
                "tray"
            ];

            battery = {
                format = "{capacity}% - {power}W - {time} {icon}";
                #tooltip-format = "{power}W";
                #format-alt = "{capacity}% {icon}";
                format-charging = "{capacity}% {time} ";
                format-icons = [ "" "" "" "" "" ];
                format-plugged = "{capacity}% ";
                states = {
                    critical = 15;
                    warning = 30;
                };
                interval = 2;
            };
            clock = {
                format = "{:%Y-%m-%d - %I:%M %p}";
                #format-alt = "{:%Y-%m-%d}";
                tooltip-format = "<big>{:%A}</big>\n<tt><small>{calendar}</small></tt>";
            };
            cpu = {
                format = "{usage}% ";
                tooltip = false;
                interval = 5;
            };
            memory = { format = "{}% "; };
            network = {
                interval = 1;
                format-alt = "{ifname}: {ipaddr}/{cidr}";
                format-disconnected = "Disconnected ⚠";
                format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
                format-linked = "{ifname} (No IP) ";
                format-wifi = "{essid} ({signalStrength}%) ";
            };
            pulseaudio = {
                format = "{volume}% {icon} {format_source}";
                format-bluetooth = "{volume}% {icon} {format_source}";
                format-bluetooth-muted = " {icon} {format_source}";
                format-icons = {
                car = "";
                default = [ "" "" "" ];
                handsfree = "";
                headphones = "";
                headset = "";
                phone = "";
                portable = "";
                };
                format-muted = " {format_source}";
                format-source = "{volume}% ";
                format-source-muted = "";
                on-click = "pavucontrol";
            };
            temperature = {
                critical-threshold = 80;
                format = "{temperatureC}°C {icon}";
                format-icons = [ "" "" "" ];
                hwmon-path-abs = "/sys/devices/platform/coretemp.0/hwmon/hwmon6";
                input-filename = "temp1_input";
            };

            power-profiles-daemon = {
                format = "{icon}";
                tooltip-format = "Power profile: {profile}nDriver: {driver}";
                tooltip = true;
                format-icons = {
                    default = "";
                    performance = "";
                    balanced = "";
                    power-saver = "";
                };
            };
        }];
    };
}