{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.vial pkgs.via ];
  services.udev = {
    packages = [
      pkgs.qmk
      pkgs.qmk-udev-rules
      pkgs.qmk_hid
      pkgs.vial
      pkgs.via
    ];
  };
}
