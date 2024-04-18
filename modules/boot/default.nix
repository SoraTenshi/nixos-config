{
  sddm-theme,
  isVM,
  ...
}: {
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint =
        if isVM
        then "/boot"
        else "/boot";
    };

    grub = {
      enable = true;
      efiSupport = true;
      copyKernels = true;
      enableCryptodisk = true;
      splashImage = "${sddm-theme}/Backgrounds/nixos.png";
      splashMode = "stretch";
      device = "nodev";
      useOSProber = true;
      fontSize = 128;
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
}
