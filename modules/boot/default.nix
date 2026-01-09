{ pkgs, useSecureBoot, useDualBoot, ... }: {
  services.ratbagd.enable = true;

  environment.systemPackages = [
    pkgs.sbctl
  ];

  boot = {
    initrd.systemd = {
      enable = true;
      tpm2.enable = true;
    };

    loader = {
      efi.canTouchEfiVariables = true;
      grub.enable = false;
      systemd-boot.enable = false;
      limine = {
        enable = true;
        efiSupport = true;
        maxGenerations = 15;
        secureBoot.enable = useSecureBoot;

        # Windows my beloved but now dying... :(
        extraEntries = (if useDualBoot then ''
          /Windows
            protocol: efi
            path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
        '' else "");
      };
    };
  };
}
