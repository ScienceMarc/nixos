{ lib, pkgs, pkgs-unstable, ... }: rec {
  imports = [];
  home = {
    username = "marc";
    homeDirectory = "/home/marc";
    stateVersion = "23.11";
    packages = with pkgs; [
      # ----- SYSTEM -----

      # fonts
      fira-code-nerdfont
      source-code-pro
      hack-font
      # nerdfonts

      # ----- cli tools -----
      tree
      gnumake
      wget
      btop
      zip
      loc
      jq
      yq
      pandoc
      fzf
      globalprotect-openconnect
      tmux
      git
      neofetch
      lshw

      # ----- dev -------
      go

      # ----- applications -----
    
        # communication
        discord
        signal-desktop
        thunderbird
        qpwgraph

        # productivity
        logseq
        obsidian
	onlyoffice-bin
        
        # other
        qbittorrent
        
        vlc

        gnomecast

	plasma-browser-integration
      	
	
    ];
    sessionVariables = {
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_STATE_HOME  = "$HOME/.local/state";

      EDITOR = "nvim";
      BROWSER = "firefox";
      #TERMINAL = "alacritty";
      #TERM = "alacritty";

      #NIXOS_OZONE_WL = "1";
    };
  };
  
  programs.home-manager.enable = true;


  xdg = {
    mime.enable = true;
    # mimeApps = {
    #   enable = true;
    #   defaultApplications = {
    #     "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop;";
    #   };
    #   #defaultApplications = {
    #   #  "word"
    #   #};
    # };
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_MISC_DIR = "${home.homeDirectory}/Misc";
      };
    };
  };

  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = ["qemu:///system"];
  #     uris = ["qemu:///system"];
  #   };
  # };



  fonts.fontconfig.enable = true;


  programs.firefox.enable = true;

  programs.gpg = {
    enable = true;
  };
  services.gpg-agent.enable = true;
  
  programs.direnv = {
    enable = true;
    config = {};
  };
  
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      
    ];
  };
}

