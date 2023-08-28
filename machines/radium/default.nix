{ ... }:
{
  imports = [
    ../../configuration.nix
  ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-intel" ];
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

  swapDevices = [];

  security.sudo.wheelNeedsPassword = false;

  networking.firewall.enable = false;

  system.stateVersion = "unstable";
}
