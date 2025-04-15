# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, nixpkgs-unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./desktop/hardware-configuration.nix
      ./shared.nix
    ];
  networking.hostName = "marc-desktop";

  # Set your time zone.
  time.timeZone = "America/Chicago";

  #boot.kernelPackages = pkgs.linuxPackages_testing;
  boot.kernelPackages = pkgs.linuxPackages_latest;


  #systemd.network.enable = true;

  # GPU settings

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.windowManager.fluxbox.enable = true;
  services.xserver.displayManager.startx.enable = true;

  services.xserver.enable = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  #chaotic.mesa-git.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marc = {
    packages = with pkgs; [
      ckb-next
      gparted
      amdgpu_top

    
    ];
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb",  ATTRS{idVendor}=="0416", ATTRS{idProduct}=="5020", MODE="0666"
    KERNEL=="hidraw*", ATTRS{idVendor}=="0416", ATTRS{idProduct}=="5020", MODE="0666"
  '';

  systemd.services.NetworkManager-wait-online.enable = false;

  # swapDevices = [ {
  #   device = "/var/lib/swapfile";
  #   size = 64*1024; # Size in MiB
  # } ];

  zramSwap.enable = true;


  hardware.ckb-next.enable = true;

  environment.systemPackages = with pkgs; [
    #nixpkgs-unstable.mesa
  ];

  services.tailscale.enable = true;
}
