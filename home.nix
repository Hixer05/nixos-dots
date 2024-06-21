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
  
  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    
    settings = {
      "$mainMod" = "SUPER"; 
      monitor = [ "HDMI-A-1,preferred,auto,1" "Unknown-1, disable"];
      "$terminal" = "alacritty";
      "$menu" = "wofi --show drun";
      
      env = [
        "XDG_CURRENT_DESKTOP,hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XCURSOR_SIZE,36"
        "QT_QPA_PLATFORM,wayland"
      ];

      exec-once = [
        "kdeconnectd&"
      ];
      
      # Look and feel
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };
      decoration = {
        rounding = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_is_master = true;
      };
      misc.force_default_wallpaper = 1;
    input = {
      kb_layout = "us";
	    kb_variant = "intl";
	    kb_options = "ctrl:swapcaps";
      follow_mouse = 1;
      sensitivity = 0;
    };
    bind = [
      "$mainMod, Q, exec, $terminal"
      "$mainMod, C, killactive, "
      "$mainMod, M, exit, "
      "$mainMod, R, exec, $menu"
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

    ];
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
    windowrulev2 = "suppressevent maximize, class:.*";   
    };
  };
 
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
