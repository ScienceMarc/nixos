{ lib, pkgs, ... }: {
    home.packages = with pkgs; [
        oh-my-zsh
        zsh
        # zsh-completions
        # zsh-powerlevel10k
        # zsh-history-substring-search
        # zsh-autosuggestions
        # zsh-fast-syntax-highlighting
        # zsh-autocomplete
        zoxide
    ];

    # users.users.marc.shell = pkgs.zsh;
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        initExtra = ''
        bindkey -M menuselect '\r' .accept-line
        '';
        #autosuggestions.enable = true;
        shellAliases = {
            "hm" = "home-manager";
            "vim" = "nvim";
            "switch" = "sudo nixos-rebuild switch";
            "ff" = "fastfetch";
            "inst" = "nix-shell -p";
            "fd" = "cd $(dirname $(fzf))";
            "cd" = "z";
            "temp" = "cd $(mktemp -d)";
        };
        oh-my-zsh = {
            enable = true;
            theme = "robbyrussell";
            # plugins = [ "git" "zsh-autosuggestions" "zsh-fast-syntax-highlighting" "zsh-autocomplete" ];
        };
        plugins = [
            {
                name = "zsh-autosuggestions";
                src = pkgs.zsh-autosuggestions;
                file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
            }
            {
                name = "zsh-fast-syntax-highlighting";
                src = pkgs.zsh-fast-syntax-highlighting;
                file = "share/zsh/site-functions";
            }
            {
                name = "zsh-autocomplete";
                src = pkgs.zsh-autocomplete;
                file = "share/zsh-autocomplete/zsh-autocomplete.plugin.zsh";
            }
        ];
    };

    programs.zoxide.enable = true;

}