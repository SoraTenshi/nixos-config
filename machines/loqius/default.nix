{ modulesPath, ... }:

{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../configuration.nix
  ];

  boot = {
    initrd.luks.devices = {
      root = {
        device = ""; # todo
        preLVM = true;
      };
    };
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "usbhid" ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
  };

  networking = {
    hostName = "loqius";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces = {
      # todo
      # enp0s31f6.useDHCP = true;
      # wlp4s0.useDHCP = true;
    };
  };

  # touchpad support!
  services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  fileSystems."/" =
    { # todo
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { # todo
      fsType = "vfat";
    };

  swapDevices =
    [ { # todo
     }
    ];

  system.stateVersion = "23.05";
}
