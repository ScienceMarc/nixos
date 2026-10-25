{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.hyprpaper = {
  enable = true;
  settings = {
    wallpaper = [
      {
        monitor = "eDP-1";
        path = "/home/marc/image.jpg";
      }
      {
        monitor = "DP-1";
        path = "/home/marc/Pictures/background2.jxl";
      }
      {
        monitor = "HDMI-A-1";
        path = "/home/marc/Pictures/background3.jxl";
      }
      {
        monitor = "DP-2";
        path = "/home/marc/Pictures/background4.jxl";
      }
    ];
  };
};
}
