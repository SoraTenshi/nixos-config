{ self, pkgs, sddm-theme, ... }:

let
  defaultUser = "dreamer";
in
{
  imports = [
    ./shared.nix
    # ../ui/wl/riverwm.nix
    ../ui/x11/sddm.nix
  ];

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
      useOSProber = true;
      fontSize = 32;
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
  time.hardwareClockInLocalTime = true;

  i18n = {
    defaultLocale = "ja_JP.utf8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.allowUnfree = true;
  
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
  
  environment.systemPackages = with pkgs;[
    opensc fcitx5-configtool
    
    exa zoxide bat
  ];

  services.pcscd.enable = true;
  programs.ssh = {
    startAgent = true;
    agentPKCS11Whitelist = "${pkgs.opensc}/lib/opensc-pkcs11.so";
  };

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
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Lilex" ]; })
  ];

  system.stateVersion = "unstable";
}
