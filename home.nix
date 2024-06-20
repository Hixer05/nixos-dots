{ config, pkgs, ... }:

{
  home.username = "william";
  home.homeDirectory = "/home/william";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    nerdfonts
    ubuntu_font_family
    iosevka
    fira-code-symbols

    hyprshot
    swaybg
    wofi
    pavucontrol
    eww
    bluez
    bluez-tools

    libsForQt5.kdeconnect-kde
    vorta
    easyeffects
    firefox
    alacritty
    telegram-desktop
    keepassxc
    krita
    lutris
    winetricks
    heroic
    syncthing
    qbittorrent
    discord
    
    
    nil #emacs nix lsp
    texliveFull
    pandoc
    
    
    htop
    neofetch

    protonup
    protonup-qt

    meson
    gcc
    clang-tools
    ninja
  ];

   

  programs.emacs.enable = true;
  
  # services = {
  #   syncthing = {
  #     enable = true;
  #     user = "William";
  #     dataDir = "/home/william/Documenti";
  #     configDir = "/home/william/Documents/.config/syncthing";
  #     overrideDevices = true;     # overrides any devices added or deleted through the WebUI
  #     overrideFolders = true;     # overrides any folders added or deleted through the WebUI
  #     settings = {
  #       devices = {
  #         "device1" = { id = "afsfdsd"; };

  #       };
  #       folders = {
  #         "org-roam" = {         # Name of folder in Syncthing, also the folder ID
  #           path = "/home/william/org-roam";    # Which folder to add to Syncthing
  #           devices = [ "device1" ];      # Which devices to share the folder with
  #         };
  #       };
  #     };
  #   };
  # };
  
  
#  wayland.windowManager.hyprland = {
#   enable = true;
#    xwayland.enable = true;
#
#    settings = {
#      "$mainMod" = "SUPER"; 
#      monitor = ",preferred,auto,1";
#
#      env = [
#        "XDG_CURRENT_DESKTOP,Hyprland"
#        "XDG_SESSION_TYPE,wayland"
#        "XDG_SESSION_DESKTOP,Hyprland"
#        "XCURSOR_SIZE,36"
#        "QT_QPA_PLATFORM,wayland"
#      ];
#      input = {
#        kb_layout = "us";
#	kb_variant = "intl";
#	kb_options = "ctrl:swapcaps";
#      };
#    };
#  };
  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
