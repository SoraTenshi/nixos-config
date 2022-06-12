{ pkgs, config, lib, nixos-hardware, modulesPath, sddm-theme, ... }:
{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../configuration.nix
  ];

  boot = {
    initrd.availableKernelModules = [ "sdhci_pci" "usb_storage" "ehci_pci" ];
    kernelModules = [ ];
    extraModulePackages = [ ];
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

  fileSystems."/" = {
      device = "/dev/disk/by-label/NIXMAIN";
      fsType = "ext4";
    };

    fileSystems."/boot/efi" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };

  swapDevices = [{
      device = "/dev/disk/by-label/swap";
    }
  ];

  networking = {
    hostName = "neoncity";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces = {
      enp0s25.useDHCP = true;
      wlp3s0.useDHCP = true;
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver = {
    enable = true;
    # touchpad support!
    libinput.enable = true;
  };

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

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    jetbrains-mono
    meslo-lgs-nf
    rictydiminished-with-firacode
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.ssh.startAgent = true;

  users.users."dreamer" = {
    isNormalUser = true;
    initialPassword = "12345";
    group = "users";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "22.05";
}
