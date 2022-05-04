{ pkgs, config, lib, nixos-hardware, modulesPath, ... }:
{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../configuration.nix
    ../../applications/sddm.nix
  ];

  boot = {
    initrd.availableKernelModules = [ "sdhci_pci" "usb_storage" "ehci_pci" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  fileSystems."/" = {
      device = "/dev/disk/by-label/NIXMAIN";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };

  swapDevices = [{
      device = "/.swapfile";
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
    displayManager.defaultSession = "none+leftwm";
    windowManager.leftwm.enable = true;
    # touchpad support!
    libinput.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";
  fonts.fonts = with pkgs; [
    jetbrains-mono
    meslo-lgs-nf
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.ssh.startAgent = true;

  users.users."dreamer" = {
    isNormalUser = true;
    initialPassword = "12345";
    group = "users";
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
