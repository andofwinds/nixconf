# Structure: 
# |-User
# |-Packages
# | |-Programs
#     |-Shell
# | |-Services
# |-Networking
# |-Hardware
# |-System
# |-Locale
# |-Audio
# |-Boot

{ config, pkgs, ... }:
  {
    imports = [ ./hardware-configuration.nix ];

### USERS
    users = {
        users.andofwinds = {
        isNormalUser = true;
        description = "and";
        extraGroups = [
          "wheel"
          "dialout"
          "networkmanager"
        ];
      };
      defaultUserShell = pkgs.zsh;
    };

### PACKAGES
    nixpkgs.config = {
      allowUnfree = true;
    };
    environment.systemPackages = with pkgs;
    [
      wget
      neovim
      discord
      neofetch
      git
      gcc
      wineWowPackages.full
      winetricks
      rustup
      nodejs
      create-react-app
      pkg-config
      nasm
      telegram-desktop
      xorg.libX11
      arduino-ide
      gnome.ghex
      gnome.adwaita-icon-theme
      gnome.gnome-tweaks
      gnumake
      vlc
      zoxide
      openssl
      cava
      zsh-syntax-highlighting
      zsh-autosuggestions
    ];
    fonts.packages = with pkgs;
    [
      nerdfonts
    ];

### PROGRAMS
    programs = {
      firefox.enable                = true;
      nix-ld.enable                 = true;

    ### SHELL  
      zsh = {
        enable                      = true;
        ohMyZsh.enable              = true;
        enableCompletion            = true;
        autosuggestions.enable      = true;
        syntaxHighlighting.enable   = true;
        shellAliases = {
          "confsw" = "nixos-rebuild switch";
        };
      };
    };
### SERVICES
  services = {
    flatpak.enable                = true;
    samba.enable                  = true;
    xserver = {
      enable                      = true;
      displayManager.gdm.enable   = true;
      desktopManager.gnome.enable = true;
    };
  };

### NETWORKING
    networking = {
      networkmanager.enable = true;
      firewall = {
        enable = true;
        allowedTCPPorts = [80 443];
        allowedUDPPortRanges = [
          { from = 4000; to = 4010; }
          { from = 8000; to = 8010; }
        ];
      };
    };

### HARDWARE
    hardware = {
      bluetooth = {
        enable                  = true;
        powerOnBoot             = true;
      };
      opengl.enable             = true;
      pulseaudio.enable         = false;
    };

### SYSTEM
    system.stateVersion = "23.11";

### LOCALE
    i18n = {
      defaultLocale = "en_US.UTF-8";
    };
    time.timeZone = "Europe/Moscow";

### AUDIO
    sound.enable = true;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

### BOOT
    boot.loader = {
      systemd-boot.enable           = true;
      efi.canTouchEfiVariables       = true;
    };
  }
