{ pkgs, useSecureBoot, ... }: {
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
      limine = {
        enable = true;
        efiSupport = true;
        maxGenerations = 15;
        secureBoot.enable = useSecureBoot;

        # Windows my beloved but now dying... :(
        extraEntries = ''
          /Windows
            protocol: efi
            path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
        '';
      };
    };
  };
}
