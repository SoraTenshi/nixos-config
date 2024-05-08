{ modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../configuration.nix
  ];

  boot = {
    initrd.availableKernelModules =
      [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
  };

  networking = {
    hostName = "serotonine";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces = {
      enp0s31f6.useDHCP = true;
      wlp4s0.useDHCP = true;
    };
  };

  # touchpad support!
  services.xserver.libinput.enable = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6939f3c9-d0e8-42cf-ab2f-cc2b184f637d";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/B1B4-DF6F";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/b28aea64-8b57-405d-a64f-d17f425cf472"; }];

  system.stateVersion = "unstable";
}
