{ pkgs, config, lib, nixos-hardware, modulesPath, ... }:
{
  imports = [ 
    ../../configuration.nix
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.lenovo-thinkpad-t420
    nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot = {
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

  users.users."dreamer" = {
    isNormalUser = true;
    initialPassword = "12345";
    group = "users";
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
