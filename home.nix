{ lib, pkgs, pkgs-unstable, pkgs-master, ... }: rec {
  imports = [
    ./home/zsh/zsh.nix
    ./home/hyprland/hyprland.nix
  ];
  home = {
    username = "marc";
    homeDirectory = "/home/marc";
    stateVersion = "25.11"; # NEVER CHANGE ME AGAIN
    packages = with pkgs; [
      # ----- SYSTEM -----

      # fonts
      nerd-fonts.fira-code
      source-code-pro
      hack-font
      font-awesome
      # nerdfonts

      # ----- cli tools -----
      tree
      gnumake
      wget
      btop-rocm
      zip
      tokei
      jq
      yq
      pandoc
      fzf
      #globalprotect-openconnect
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
      imagemagick
      bc

      # ----- dev -------
      go
      gcc
      cargo
      python3
      nodejs

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
      onlyoffice-desktopeditors
      xournalpp
      audacity
      obs-studio

      # visual editing
      krita
      gimp
      blender-hip

      # games
      steam
      gamescope
      mangohud
      protonup-ng
      prismlauncher
      pkgs-master.vintagestory
      
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
      wf-recorder
      resources
      pavucontrol
      nix-output-monitor
      appimage-run
      yt-dlp
      solaar
      #chromium

      # btrfs
      compsize
      btrfs-list


      # radio
      dump1090-fa
      sdrpp
      rtl_433
      flrig
      hamlib
      wsjtx
      js8call
      fldigi
      gridtracker
      tqsl

      # Compatability
      wine
      winetricks
      bottles

      nautilus

      # kde apps
      #kdePackages.dolphin
      kdePackages.okular
      kdePackages.kate
      kdePackages.gwenview
      kdePackages.ark
          	
      # debug
      mesa-demos

      # 3d printing
      prusa-slicer
      freecad

	
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

      NIXOS_OZONE_WL = "1";
    };
  };
  
  programs.home-manager.enable = true;

  home.activation.homeManagerSymlink = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run ln $VERBOSE_ARG -sfnT "${home.homeDirectory}/.config/nixos" "${home.homeDirectory}/.config/home-manager"
  '';

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
    nix-direnv.enable = true;
    config = {};
  };
  
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      
    ];
  };
  #services.mozillavpn.enable = true;

  
}

