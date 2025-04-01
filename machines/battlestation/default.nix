{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd = {
      availableKernelModules =
        [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      #kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" "vfio_virqfd" "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    # kernelParams = [ "amd_iommu=on" "vfio-pci.ids=${builtins.concatStringsSep "," ids}" ];
    kernelParams = [ ];
  };

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  environment.systemPackages = [ pkgs.egl-wayland pkgs.nvidia-vaapi-driver ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b20bc060-36e0-4197-9038-4b3113064540";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/BFC1-4BB5";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [{ device = "/dev/disk/by-uuid/460f529b-50b8-47e3-aaa8-1b06c28151a5"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking = {
    hostName = "battlestation";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    useDHCP = false;
    interfaces.enp4s0.useDHCP = true;
  };

  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "24.11";
}
