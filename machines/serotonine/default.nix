{ modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../configuration.nix
  ];

  boot = {
    loader.grub.enable = false;
    initrd = {
      availableKernelModules =
      [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
      luks.devices = {
        "luks-e01d32cc-69b9-47c1-a516-98b90b43a4b6".device =
          "/dev/disk/by-uuid/e01d32cc-69b9-47c1-a516-98b90b43a4b6";
        "luks-6738eef5-76f2-466b-8444-018b59f06883".device =
          "/dev/disk/by-uuid/6738eef5-76f2-466b-8444-018b59f06883";
      };
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
  };

  networking = {
    hostName = "serotonine";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    useDHCP = false;
    interfaces = {
      enp0s31f6.useDHCP = true;
      wlp4s0.useDHCP = true;
    };
  };

  # touchpad support!
  services.libinput.enable = true;

  fileSystems."/" = {
    device = "/dev/mapper/luks-e01d32cc-69b9-47c1-a516-98b90b43a4b6";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/BC4B-4DFB";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/mapper/luks-6738eef5-76f2-466b-8444-018b59f06883"; }
    ];


  system.stateVersion = "25.11";
}
