{config, pkgs, ...}:

{
    imports = [ ./laptop/hardware-configuration.nix ./shared.nix ];

    networking.hostName = "marc-fw13"; # Define your hostname.

    # Timezone must be set imperatively because auto timzeone stuff didn't work
    time.timeZone = null;

    swapDevices = [{
        device = "/swapfile";
        size = 16 * 1024; # Size of swap in MB
    }];


    # services.thermald.enable = true;
    # powerManagement.enable = true;

    services.xserver.xkb = {
        layout = "us";
        variant = "altgr-intl";
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;
    services.power-profiles-daemon.enable = true;

    services.fwupd.enable = true;
}
