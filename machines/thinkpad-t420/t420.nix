{ pkgs, config, lib, nixos-hardware, modulesPath, ... }:
{
  imports =
  [ (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "ehci_pci" "ahci" "firewire_ohci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" ];
      kernelModules = [ ];
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-label/NIXMAIN";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };

  swapDevices = [ 
    {
      device = "/.swapfile";
    }
  ];

  networking.hostName = "neoncity";
  networking.networkmanager.enable = true;

  sound.enable = true;


  time.timeZone = "Europe/Berlin";
  fonts.fonts = with pkgs; [
    jetbrains-mono
    meslo-lgs-nf
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  users.users."dreamer" = {
    isNormalUser = true;
    initialPassword = "12345";
    group = "users";
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
