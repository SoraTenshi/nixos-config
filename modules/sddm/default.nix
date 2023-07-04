{ pkgs, sddm-theme, ... }:
{
  qt = {
    enable        = true;
    platformTheme = "gtk2";
    style         = "gtk2";
  };

	environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtgraphicaleffects
	];

  services.xserver.displayManager = {
    sddm = {
      enable = true;
      theme  = "${sddm-theme}";
    };
  };
}
