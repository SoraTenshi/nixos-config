{ config, pkgs, sddm-theme, ... }:
{
  qt5 = {
    enable = true;
    style = "gtk2";
    platformTheme = "gtk2";
  };


  services.xserver.displayManager = {
    sddm = {
      enable = true;
      theme = "${sddm-theme}";
    };
  };
}
