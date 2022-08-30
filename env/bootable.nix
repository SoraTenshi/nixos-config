{ pkgs, sddm-theme, ... }:

let
  defaultUser = "dreamer";
in
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      efiSupport = true;
      copyKernels = true;
      splashImage = "${sddm-theme}/Backgrounds/nixos.png";
      splashMode = "stretch";
      device = "nodev";
      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';
    };
  };

  time.timeZone = "Europe/Berlin";

  console.keyMap = "us";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        mozc
      ];
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.allowUnfree = true;

  # services.xserver = {
  #   enable = true;
  #   displayManager.defaultSession = "none+leftwm";
  #   desktopManager.runXdgAutostartIfNone = true;
  #   windowManager.leftwm.enable = true;
  #   # touchpad support!
  #   libinput.enable = true;
  # };

  services.xserver = {
    enable = true;
    displayManager.defaultSession = "none+xmonad";
    desktopManager.runXdgAutostartIfNone = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        pkgs.xmonad-log
      ];
      config = ../xmonad/xmonad.hs;
    };
  };

  programs.ssh.startAgent = true;

  users.users.${defaultUser} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    initialPassword = "12345";
    group = "users";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    jetbrains-mono
    meslo-lgs-nf
    rictydiminished-with-firacode
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  system.stateVersion = "22.11";
}
