{ lib, pkgs, pkgs-unstable, ... }: rec {
  imports = [
    ./home/zsh/zsh.nix
    ./home/hyprland/hyprland.nix
  ];
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
      fastfetch
      lshw
      ffmpeg
      rclone
      discordchatexporter-cli
      cmatrix
      powertop
      mc
      file

      # ----- dev -------
      go
      gcc

      # ----- applications -----
    
      # communication
      discord
      signal-desktop
      thunderbird
      qpwgraph
      telegram-desktop
      zoom-us
      vesktop

      # productivity
      logseq
      obsidian
      onlyoffice-bin
      xournalpp

      # visual editing
      krita
      gimp

      # games
      steam
      mangohud
      protonup
      
      # other
      qbittorrent
      vlc
      gnomecast
      stellarium
      handbrake
      electrum
      qdirstat
	    #plasma-browser-integration
      veikk-linux-driver-gui
      linux-wifi-hotspot
      tor-browser

      	
	
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

  programs.git = {
    enable = true;
    userName = "Marc Lavergne";
    userEmail = "marc.lavergne@hotmail.com";
  };
  #services.mozillavpn.enable = true;
}

