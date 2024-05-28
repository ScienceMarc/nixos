{ lib, pkgs, ... }: {
    home.packages = with pkgs; [
        oh-my-zsh
        # zsh
        zsh-completions
        zsh-powerlevel10k
        zsh-history-substring-search
        zsh-autosuggestions
        zsh-fast-syntax-highlighting
        zsh-autocomplete
    ];

    # users.users.marc.marc.shell = pkgs.zsh;
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        #autosuggestions.enable = true;
        shellAliases = {
            "hm" = "home-manager";
            "vim" = "nvim";
            "switch" = "sudo nixos-rebuild switch";
        };
        oh-my-zsh = {
            enable = true;
            theme = "robbyrussell";
            # plugins = [ "git" "zsh-autosuggestions" "zsh-fast-syntax-highlighting" "zsh-autocomplete" ];
        };
    };
}