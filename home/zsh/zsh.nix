{ lib, pkgs, ... }: {
    home.packages = with pkgs; [
        #oh-my-zsh
        #prezto
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
        # initExtra = ''
        # bindkey -M menuselect '\r' .accept-line
        # '';
        #autosuggestions.enable = true;
        shellAliases = {
            "hm" = "home-manager";
            "vim" = "nvim";
            "switch" = "sudo nixos-rebuild switch";
            "build" = "sudo nixos-rebuild build |& nom";
            "update" = "(sudo echo 'beginning update') && (cd /etc/nixos && nix flake update) && (sudo nixos-rebuild switch) |& nom && (home-manager switch |& nom)";
            "ff" = "fastfetch";
            "inst" = "nix-shell --command 'zsh' -p";
            "fd" = "cd $(dirname $(fzf))";
            "cd" = "z";
            "temp" = "cd $(mktemp -d)";
            "ztar" = "tar --zstd -cvf";
        };
        # oh-my-zsh = {
        #     enable = true;
        #     theme = "robbyrussell";
        # };

        prezto = {
            enable = true;
        };

        plugins = [
            {
                name = "zsh-autosuggestions";
                src = pkgs.zsh-autosuggestions;
                file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
            }
            
            # {
            #     name = "zsh-fast-syntax-highlighting";
            #     src = pkgs.zsh-fast-syntax-highlighting;
            #     file = "share/zsh/site-functions";
            # }
            # {
            #     name = "zsh-autocomplete";
            #     src = pkgs.zsh-autocomplete;
            #     file = "share/zsh-autocomplete/zsh-autocomplete.plugin.zsh";
            # }
        ];
    };

    programs.zoxide.enable = true;

}