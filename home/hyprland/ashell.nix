{config, pkgs, lib, ...}: {
    programs.ashell = {
        enable = true;
        settings = {
            modules = {
            left = [ "Workspaces" ];
            center = [ "WindowTitle" ];
            right = [
                [
                "Tray"
                "Tempo"
                "Privacy"
                "Settings"
                ]
            ];
            };

            workspaces = {
                visibility_mode = "MonitorSpecificExclusive";
            };

            tempo = {
                clock_format = "%a %d %b %-I:%M%p";
            };

            tray = {
                right_click = "menu";
                blocklist = [ ];
            };
        };
    };
}