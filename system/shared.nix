# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  # imports = [
  #   ../home/zsh/zsh.nix
  # ];
  imports = [
    # ../special/veikk/veikk.nix
  ];

  nix = {
    package = pkgs.nixVersions.stable;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  #nixpkgs.config.allowUnfree = true;


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.systemd-boot.configurationLimit = 5; # Keep the last 5 boot entries

  # Enable networking
  networking.networkmanager.enable = true;


  # Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";


  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "kde";
  };

  # Xfce
  #services.xserver.desktopManager.xfce.enable = true;

  # Enable hyprland
  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable man page caches
  documentation.man.generateCaches = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Blacklisted modules
  boot.blacklistedKernelModules = [ 
    "dvb_usb_rtl28xxu" # For SDRs
  ];

  # Enable sound with pipewire.
  #sound.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  environment.systemPackages = with pkgs; [
    #zsh
    neovim
    firefox
    #kate
    mullvad-vpn
    qemu
    virt-manager
    libvirt-glib
  ];
  users.users.marc = {
    isNormalUser = true;
    description = "marc";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "render" "dialout" "libvirt" "docker" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = false;

  programs.gamemode.enable = true;
  services.mullvad-vpn.enable = true;

  # Virtual machines
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Enable Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };


  security.polkit.enable = true;

  # Printers
  services.avahi.enable = true;

  # USB automounting
  services.gvfs.enable = true;

  services.ollama = {
    enable = true;
    acceleration = "rocm";
  };

  # nix.gc = {
  #   automatic = true;
  #   dates = "monthly";
  # };

  system.stateVersion = "25.05";
}
