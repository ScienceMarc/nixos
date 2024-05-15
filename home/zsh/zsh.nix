{ lib, pkgs, ... }: {
    programs.zsh = {
        enable = true;
        shellAliases = {
            "hm" = "home-manager";
            "vim" = "nvim";
        };
        oh-my-zsh = {
            enable = true;
            theme = "robbyrussell";
        };
    };
}