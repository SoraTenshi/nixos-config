{ config, pkgs, sddm-theme, ... }:
{
  services.xserver.displayManager = {
    defaultSession = "none+leftwm";
    sddm = {
      enable = true;
      theme = "tokyo-night-sddm";
    };
  };

  home.file = {
    "/usr/share/sddm/themes" = {
      source = "${sddm-theme}";
    };
  };
}
