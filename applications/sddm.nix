{ config, pkgs, sddm-theme, ... }:
{
  qt5 = {
    enable = true;
    style = "gtk2";
    platformTheme = "gtk2";
  };

  environment.systemPackages = with pkgs; [
    # GTK 
    gtk3.dev gtk4.dev

    libsForQt5.full
  ];

  services.xserver.displayManager = {
    sddm = {
      enable = true;
      theme = "${sddm-theme}";
    };
  };
}
