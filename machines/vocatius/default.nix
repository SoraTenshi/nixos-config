{ pkgs, config, modulesPath, lib, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd = {
      kernelModules = [ "i915" ];
      availableKernelModules =
        [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];

      luks.devices = {
        "luks-06f18c4c-8042-4568-a1da-28f99e41fa1c".device =
          "/dev/disk/by-uuid/06f18c4c-8042-4568-a1da-28f99e41fa1c";
        "luks-bc52c8db-7acd-4e9f-81c4-13f442041b24".device =
          "/dev/disk/by-uuid/bc52c8db-7acd-4e9f-81c4-13f442041b24";
      };
    };
    kernelModules = [ "v4l2loopback" "kvm-intel" "wireguard" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    intel-gpu-tools.enable = true;
    graphics= {
      package = pkgs.mesa.drivers;
      enable32Bit = true;
      package32 = pkgs.pkgsi686Linux.mesa.drivers;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
  };

  environment.systemPackages = [
    pkgs.intel-ocl
    pkgs.intel-vaapi-driver
    pkgs.vaapiIntel
    pkgs.vaapiVdpau
    pkgs.libvdpau-va-gl
    pkgs.egl-wayland
  ];

  services.upower.enable = true;

  networking = {
    hostName = "vocatius";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    useDHCP = false;
    interfaces = {
      eno1.useDHCP = true;
    };
    wireguard.enable = true;
    firewall = {
      allowedUDPPorts = [ 5182 ];
      logReversePathDrops = true;
      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 5182 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 5182 -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 5182 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 5182 -j RETURN || true
      '';
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f4158a43-6e4c-4c61-8c97-895470eed2d2";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D665-5172";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/ec3eb762-055f-4340-8230-58c0395e6edc"; }];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  system.stateVersion = "24.11";
}
