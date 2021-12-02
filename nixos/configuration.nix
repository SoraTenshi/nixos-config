# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "neoncity"; # Define your hostname.
  # Enable the wlan interface '$ ip link show'
  #  networking.wireless = {
  #    enable = true;
  #    userControlled.enable = true;
  #    interfaces = [ "wlp3s0" ];
  #  };
  networking.networkmanager.enable = true;

  # Enable auto update
  # systems.autoUpgrade.enable = true;


  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.defaultSession = "none+leftwm";
  services.xserver.windowManager.leftwm.enable = true; 
  

  # Configure keymap in X11
  services.xserver = { 
    layout = "us";
  #  xkbVariant = "colemak";
    xkbOptions = "eurosign:e";
  };

  # Enable japanese input method
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ mozc ];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dreamer = {
    isNormalUser = true;
    initialPassword = "P4$$w0rd";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Hipster using lightweight text editors... well not anymore :-)
    spacevim 
    
    # Universal tools
    wget

    # Has to have nixpkgs.config.allowUnfree set to true
    vivaldi

    # WM Fuckery
    leftwm rofi polybar nitrogen pywal rofi-power-menu picom

    # Code specific stuff
    cargo rustup rustc gcc git clang go pythonFull 

    # because i want to flex that i use nixos :P
    neofetch

    # util
    bat ibus-engines.mozc pmount feh networkmanager_dmenu dmenu

    # kbd system
    # haskellPackages.kmonad

    # nix utils
    nix-prefetch-github
  ];

  fonts.fonts = with pkgs; [
    jetbrains-mono
    meslo-lgs-nf
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.bash.shellAliases = {
    sudo = "sudo ";
    cat = "bat";
    vim = "spacevim";
    locate = "mlocate";
  };

  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    shadow = true;
    shadowOpacity = 0.5;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

