{ pkgs, config, modulesPath, lib, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../configuration.nix
  ];

  boot = {
    initrd = {
      availableKernelModules =
        [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" ];

      luks.devices = {
        "luks-8c09cc4c-b161-41a5-9894-f6b1ee241176".device =
          "/dev/disk/by-uuid/8c09cc4c-b161-41a5-9894-f6b1ee241176";
        "luks-f4d4ec1c-5556-4e7f-8eed-de692a3c40f1".device =
          "/dev/disk/by-uuid/f4d4ec1c-5556-4e7f-8eed-de692a3c40f1";
      };
    };
    kernelModules = [ "v4l2loopback" "kvm-intel" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
  };

  services.upower.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  networking = {
    hostName = "loqius";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    useDHCP = false;
    interfaces = {
      enp0s13f0u1u4c2.useDHCP = true;
      enp0s31f6.useDHCP = true;
      wlp0s20f3.useDHCP = true;
    };
  };

  # touchpad support!
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ]; # ["displaylink" "modesetting"];
  };

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/11134cfa-0421-4197-b791-003514a34788";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C7ED-D0DA";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/eedd8e17-c04f-4338-8baf-bf6b5ca11688"; }];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  system.stateVersion = "23.05";
}
