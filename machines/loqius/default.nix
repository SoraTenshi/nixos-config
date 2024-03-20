{ pkgs, config, modulesPath, ... }:

{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../configuration.nix
  ];

  boot = {
    initrd = {
        availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];

        luks.devices = {
            "luks-02f3657f-1e4b-4c27-8699-14b6c7800fe8".device = "/dev/disk/by-uuid/02f3657f-1e4b-4c27-8699-14b6c7800fe8";
            "luks-1db63256-f82d-41cf-a676-34df3d4cdda7".device = "/dev/disk/by-uuid/1db63256-f82d-41cf-a676-34df3d4cdda7";
        };
    };
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  };

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
  };

  services.upower.enable = true;

  networking = {
    hostName = "loqius";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces = {
      enp2s0f0.useDHCP = true;
      wlp3s0.useDHCP = true;
      wwan0.useDHCP = true;
    };
  };

  # touchpad support!
  services.xserver = {
    enable = true;
    videoDrivers = [ "displaylink" "modesetting" ];
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5fcfbbcd-7bc3-4858-8424-12ded996ea9f";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/C94B-1C6E";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/f3a71f47-540f-4870-a6d2-1de0b815af48"; }
    ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
    # enableSSHSupport = true;
  };

  system.stateVersion = "23.05";
}
