{ config, pkgs, sddm-theme, ... }:
{
  

  services.xserver.displayManager = {
    sddm = {
      enable = true;
      theme = "${sddm-theme}";
    };
  };
}
