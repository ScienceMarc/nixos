{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      golang.go
      ms-vscode.cmake-tools
      ms-vscode.cpptools
      ms-vscode.cpptools-extension-pack
      platformio.platformio-vscode-ide
      vscode-icons-team.vscode-icons
      davidanson.vscode-markdownlint
    ];
  };
}