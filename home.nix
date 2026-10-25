{
  lib,
  config,
  pkgs,
  pkgs-unstable,
  pkgs-master,
  ...
}:
rec {
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
      nixfmt

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
      #logseq
      obsidian
      onlyoffice-desktopeditors
      xournalpp
      audacity
      obs-studio
      simple-scan

      # visual editing
      krita
      gimp
      pkgsRocm.blender

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
      libjxl
      usbutils
      smartmontools
      psmisc

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
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      EDITOR = "nvim";
      BROWSER = "firefox";
      #TERMINAL = "alacritty";
      #TERM = "alacritty";

      NIXOS_OZONE_WL = "1";
    };
  };

  programs.home-manager.enable = true;

  home.activation.homeManagerSymlink = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ln $VERBOSE_ARG -sfnT "${home.homeDirectory}/.config/nixos" "${home.homeDirectory}/.config/home-manager"
  '';

  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;

      defaultApplications =
        let
          kate = "org.kde.kate.desktop";
          code = "code.desktop";
          firefox = "firefox.desktop";
          okular = "org.kde.okular.desktop";
          onlyoffice = "onlyoffice-desktopeditors.desktop";
          gwenview = "org.kde.gwenview.desktop";
          vlc = "vlc.desktop";
          ark = "org.kde.ark.desktop";
          thunderbird = "thunderbird.desktop";
        in
        {
          # Text
          "text/plain" = kate;
          "text/markdown" = kate;
          "text/x-markdown" = kate;
          "text/x-log" = kate;

          # Code
          "text/x-python" = code;
          "text/x-c" = code;
          "text/x-c++" = code;
          "text/x-java" = code;
          "text/javascript" = code;
          "application/javascript" = code;
          "text/css" = code;
          "application/json" = code;
          "application/xml" = code;
          "text/xml" = code;
          "application/x-shellscript" = code;
          "text/x-script.python" = code;
          "text/x-cmake" = code;
          "text/x-rust" = code;
          "text/x-nix" = code;
          "application/yaml" = code;
          "text/yaml" = code;
          "application/x-yaml" = code;
          "application/toml" = code;
          "application/sql" = code;
          "text/x-patch" = code;
          "text/x-diff" = code;

          # Web
          "text/html" = firefox;
          "application/xhtml+xml" = firefox;
          "x-scheme-handler/http" = firefox;
          "x-scheme-handler/https" = firefox;
          "x-scheme-handler/about" = firefox;
          "x-scheme-handler/unknown" = firefox;

          # Documents
          "application/pdf" = okular;
          "application/epub+zip" = okular;
          "application/x-mobipocket-ebook" = okular;
          "application/rtf" = onlyoffice;
          "application/msword" = onlyoffice;
          "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = onlyoffice;
          "application/vnd.oasis.opendocument.text" = onlyoffice;

          # Spreadsheets
          "text/csv" = onlyoffice;
          "application/vnd.ms-excel" = onlyoffice;
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = onlyoffice;
          "application/vnd.oasis.opendocument.spreadsheet" = onlyoffice;

          # Presentations
          "application/vnd.ms-powerpoint" = onlyoffice;
          "application/vnd.openxmlformats-officedocument.presentationml.presentation" = onlyoffice;
          "application/vnd.oasis.opendocument.presentation" = onlyoffice;

          # Krita projects and editable graphics
          "application/x-krita" = "org.kde.krita.desktop";
          "image/x-psd" = "org.kde.krita.desktop";
          "image/openraster" = "org.kde.krita.desktop";

          # Common raster formats
          "image/jpeg" = gwenview;
          "image/png" = gwenview;
          "image/gif" = gwenview;
          "image/bmp" = gwenview;
          "image/tiff" = gwenview;
          "image/webp" = gwenview;
          "image/x-webp" = gwenview;

          "image/avif" = gwenview;
          "image/heif" = gwenview;
          "image/jxl" = gwenview;

          # Audio
          "audio/mpeg" = vlc;
          "audio/wav" = vlc;
          "audio/x-wav" = vlc;
          "audio/flac" = vlc;
          "audio/ogg" = vlc;
          "audio/mp4" = vlc;
          "audio/aac" = vlc;

          # Video
          "video/mp4" = vlc;
          "video/webm" = vlc;
          "video/x-msvideo" = vlc;
          "video/mpeg" = vlc;
          "video/x-matroska" = vlc;
          "video/quicktime" = vlc;
          "video/x-flv" = vlc;

          # Archives
          "application/zip" = ark;
          "application/x-tar" = ark;
          "application/gzip" = ark;
          "application/x-gzip" = ark;
          "application/x-bzip2" = ark;
          "application/x-7z-compressed" = ark;
          "application/x-rar" = ark;
          "application/vnd.rar" = ark;
          "application/x-xz" = ark;
          "application/zstd" = ark;

          # Email
          "x-scheme-handler/mailto" = thunderbird;

          # Communication
          "x-scheme-handler/discord" = "discord.desktop";
          "x-scheme-handler/telegram" = "org.telegram.desktop.desktop";
          "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
          "x-scheme-handler/zoommtg" = "Zoom.desktop";
        };
    };

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

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };

  programs.gpg = {
    enable = true;
  };
  services.gpg-agent.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = { };
  };

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [

    ];
  };
  #services.mozillavpn.enable = true;

}
