{config, pkgs, ...}:

{
    services.thermald.enable = true;
    powerManagement.enable = true;
}