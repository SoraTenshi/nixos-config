{ pkgs, sddm-theme, ... }:

let
  username = "dreamer";
in
{
  imports = [
    ./shared.nix

    ../ui/wl/riverwm.nix

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

  services.xserver = {
    enable = true;
    layout = "eu";
    displayManager.defaultSession = "none+xmonad";
    desktopManager = {
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
  ];

  services.pcscd.enable = true;
  programs.ssh = {
    startAgent = true;
    agentPKCS11Whitelist = "${pkgs.opensc}/lib/opensc-pkcs11.so";
  };

  system.stateVersion = "unstable";
}
