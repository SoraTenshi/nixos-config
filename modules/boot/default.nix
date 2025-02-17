_: {
  boot = {
    initrd.systemd = {
      enable = true;
      tpm2.enable = true;
    };

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
        configurationLimit = 10;
      };
    };
  };
}
