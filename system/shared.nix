# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # imports = [
  #   ../home/zsh/zsh.nix
  # ];

  environment.systemPackages = with pkgs; [
    zsh
  ];
  users.users.marc.shell = pkgs.zsh;
  programs.zsh.enable = true;

  nix.gc = {
    automatic = true;
    dates = "monthly";
  };
}
