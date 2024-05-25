{ pkgs, efiSysMountPoint, ... }: {
  boot = {
  initrd.systemd = {
    enable = true;
    enableTpm2 = true;
  };
  loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = efiSysMountPoint;
    };

    grub = {
      enable = true;
      efiSupport = true;
      copyKernels = true;
      enableCryptodisk = true;
      theme = "${pkgs.libsForQt5.breeze-grub}/grub/themes/breeze";
      device = "nodev";
      useOSProber = true;
      fontSize = 256;
      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';
    };
  };
};
}
