{config, pkgs, lib, ...}: {
    services.hyprpaper = {
        enable = true;
        settings = {
            wallpaper = [
                "eDP-1,/home/marc/image.jpg"
            ];
            preload = [
                "/home/marc/image.jpg"
            ];
        };
    };
}