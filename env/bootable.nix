{ pkgs, sddm-theme, ... }:

let
  defaultUser = "dreamer";
in
{
  imports = [
    ./shared.nix

    ../ui/wl/riverwm.nix
    ../ui/wl/gnome.nix

    ../ui/x11/sddm.nix
    # ../ui/x11/lightdm.nix
  ];

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

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
      fontSize = 64;
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

  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   audio.enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;

  #   # To be integrated
  #   # lowLatency = {
  #   #   enable = true;
  #   #   quantum = 64;
  #   #   rate = 48000;
  #   # };
  # };
  
  services.xserver = {
    layout = "eu";
    enable = true;
    displayManager.defaultSession = "none+xmonad";
    desktopManager = {
      gnome = {
        enable = true;
      };
      runXdgAutostartIfNone = true;
    };
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
    
    exa zoxide bat fzf

    libxkbcommon openal harfbuzz 

    pavucontrol
  ];

  services.pcscd.enable = true;
  programs.ssh = {
    startAgent = true;
    agentPKCS11Whitelist = "${pkgs.opensc}/lib/opensc-pkcs11.so";
  };

  programs.zsh.enable = true;
  users.users.${defaultUser} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    initialPassword = "12345";
    group = "users";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
  };

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    material-symbols
    meslo-lgs-nf
    rictydiminished-with-firacode
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "Lilex" ]; })
  ];

  system.stateVersion = "unstable";
}
