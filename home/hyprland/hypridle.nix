{config, pkgs, lib, ...}: {
    services.hypridle = {
        enable = true;
        settings = {
            general = {
                
            };

            listener = {
                timeout = 300;
                "on-timeout" = "hyprctl dispatch dpms off";
                "on-resume" = "hyprctl dispatch dpms on";
            };
        };
    };
}