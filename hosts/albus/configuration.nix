{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    config.allowUnfree = true;
    config.packageOverrides = {
      jdk = pkgs.graalvm11-ce;
      jre = pkgs.graalvm11-ce;
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_5_15;
    blacklistedKernelModules = [ "nouveau" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  time.timeZone = "Europe/Madrid";

  networking = {
    hostName = "albus";
    useDHCP = false;
    interfaces.enp0s31f6.useDHCP = true;
    networkmanager.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5 = {
      enable = true;
      useQtScaling = true;
      kdeglobals = { };
      kwinrc = { };
    };

    layout = "us";
    xkbVariant = "altgr-intl";
    xkbOptions = "ctrl:nocaps";

    videoDrivers = [ "nvidia" ];

    libinput.enable = true;
  };

  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jmartinez = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    # kde
    kwin-tiling
    papirus-icon-theme

    # others
    cachix
    brave
    firefox
    keepassxc
    dropbox
    synology-drive-client
    joplin-desktop
    spotify
    bitwarden
    zoom-us
  ];

  powerManagement.enable = true;

  system.stateVersion = "22.05";
}
