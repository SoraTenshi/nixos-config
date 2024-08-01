{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
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

  services.xserver = {
    # Sucks to be me, i have to adjust it every time i move cable / connections
    # Thank you x11...
    # Well also under wayland this won't work as intented.....

    # Linux desktop truly is a mess.
    displayManager.sessionCommands = ''
      xrandr \
        --output DP-4 --mode 1920x1080 --rate 165 --pos 0x1080 \
        --output HDMI-0 --mode 1920x1080 --rate 60 --pos 990x0 \
        --output DP-0 --mode 1920x1080 --rate 75 --pos 1920x1080 \
        --output DP-1 --off \
        --output DP-2 --off \
        --output DP-3 --off \
        --output DP-5 --off
    '';
  };

  environment.systemPackages = [ pkgs.egl-wayland pkgs.nvidia-vaapi-driver ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c2d3c3eb-96e5-44ea-b36c-7b5679ba48a8";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/81D1-752B";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/d4761b59-4325-4677-894f-d473e45ab3ad"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking = {
    hostName = "battlestation";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.enp4s0.useDHCP = true;
  };

  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "unstable";
}
