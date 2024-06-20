# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    
  };
  hardware.nvidia.modesetting.enable = true;  
  hardware.bluetooth.enable = true;

  
  #  X11 
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    xkb = {
      layout = "us";
      variant = "intl"; 
      options = "ctrl:swapcaps";
    };
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  services.xserver.desktopManager.xfce.enable = true;
  
  # Wayland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
   };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
  
  # Networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };  

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # Security
  security.polkit.enable = true;
 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.william = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };
  
  # Nix System
  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
     automatic = true;
     dates = "weekly";
     options = "--delete-older-than 1w";
   };

  i18n.defaultLocale = "it_IT.UTF-8"; # Select internationalisation properties.
  console.useXkbConfig = true;
  time.timeZone = "Europe/Rome";

  environment.systemPackages = with pkgs; [
     git
     borgbackup
     wine
     nvtopPackages.full
     libnotify
   ];
   
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # Devices
  fileSystems."/home/william/mnt/Backup" = {
    device = "/dev/disk/by-uuid/cb191cb2-e2ea-40b4-9958-37bb26159352";
    fsType = "ext4";
  };
  fileSystems."/home/william/mnt/Games2" = {
    device = "/dev/disk/by-uuid/9fdf8cf7-2366-4201-8683-b4e21d6b307d";
    fsType = "ext4";
  };
  
  fileSystems."/home/william/mnt/Games" = {
   device = "/dev/disk/by-uuid/24926996-946b-4768-9e69-b39d907c876e";
   fsType = "ext4";
  };
  
 
  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

