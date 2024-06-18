# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "it_IT.UTF-8";
   console = {
     font = "Lat2-Terminus16";
#     keyMap = "us";
     useXkbConfig = true; # use xkb.options in tty.
   };

   hardware.bluetooth.enable = true;
   
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  #services.displayManager.autoLogin = {
  #  user = "william";
  #  enable = true;
  #};
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

   networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };  

  
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.modesetting.enable = true;  

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "intl"; 
  services.xserver.xkb.options = "ctrl:swapcaps";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.william = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     git
     borgbackup
     wine
     nvtopPackages.full
     libnotify
   ];
   programs.hyprland = {
    enable = true;
    xwayland.enable = true;
   };
   
   services.xserver.desktopManager.xfce.enable = true;

     programs.steam.enable = true;
   programs.steam.gamescopeSession.enable = true;
   programs.gamemode.enable = true;
   
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

   # Limit the number of generations to keep
   boot.loader.systemd-boot.configurationLimit = 10;
   # boot.loader.grub.configurationLimit = 10;

   # Perform garbage collection weekly to maintain low disk usage
   nix.gc = {
     automatic = true;
     dates = "weekly";
     options = "--delete-older-than 1w";
   };
   
   # Optimize storage
   # You can also manually optimize the store via:
   #    nix-store --optimise
   # Refer to the following link for more details:
   # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
   nix.settings.auto-optimise-store = true;
   
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
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

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

