{ config, pkgs, sddm-theme, ... }:
{
  qt5 = {
    enable        = true;
    platformTheme = "gtk2";
    style         = "gtk2";
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.full
  ];

  services.xserver.displayManager = {
    sddm = {
      enable = true;
      theme  = "${sddm-theme}";
    };
  };
}
