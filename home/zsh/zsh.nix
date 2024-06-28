{ lib, pkgs, ... }: {
    home.packages = with pkgs; [
        oh-my-zsh
        zsh
        zsh-completions
        zsh-powerlevel10k
        zsh-history-substring-search
        zsh-autosuggestions
        zsh-fast-syntax-highlighting
        zsh-autocomplete
        zoxide
    ];

    # users.users.marc.shell = pkgs.zsh;
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        #autosuggestions.enable = true;
        shellAliases = {
            "hm" = "home-manager";
            "vim" = "nvim";
            "switch" = "sudo nixos-rebuild switch";
            "ff" = "fastfetch";
            "inst" = "nix-shell -p";
            "fd" = "cd $(dirname $(fzf))";
            "cd" = "z";
        };
        oh-my-zsh = {
            enable = true;
            theme = "robbyrussell";
            # plugins = [ "git" "zsh-autosuggestions" "zsh-fast-syntax-highlighting" "zsh-autocomplete" ];
        };
    };

    programs.zoxide.enable = true;

}