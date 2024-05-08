{ modulesPath, ... }: {
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix") ../../configuration.nix ];

  boot = {
    initrd.availableKernelModules =
      [ "xhci_pci" "virtio_pci" "usbhid" "nvme" "usb_storage" "sr_mod" ];
    kernelModules = [ ];
    extraModulePackages = [ ];
    binfmt.emulatedSystems = [ "x86_64-linux" ];
  };

  networking = {
    hostName = "radium";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.ens160.useDHCP = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXMAIN";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
  };

  swapDevices = [ ];

  environment.variables.LIBGL_ALWAYS_SOFTWARE = "1";

  services.xserver = {
    # Sucks to be me, i have to adjust it every time i move cable / connections
    # Thank you x11...
    # Well also under wayland this won't work as intented.....

    # Linux desktop truly is a mess.
    displayManager.sessionCommands = ''
      xrandr \
        --output Virtual-1 --mode 1512x982 --rate 60 --pos 0x0 \
    '';
  };

  security.sudo.wheelNeedsPassword = false;

  networking.firewall.enable = false;

  system.stateVersion = "unstable";
}
