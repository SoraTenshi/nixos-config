{ config, pkgs, lib, nixos-hardware, sddm-theme, ... }:
{
  services.xserver.displayManager = {
    sddm = {
      enable = true;
      theme = "tokyo-night-sddm";
    };
  };

  home.file = {
    "/usr/share/sddm/themes/tokyo-night-sddm" = {
      source = "${sddm-theme}";
    };
  };
}
