{ pkgs, ... }: {
  imports = [ ./hyprland ./river ];

  home.packages = [
    pkgs.xdg-desktop-portal-cosmic
    pkgs.xdg-desktop-portal-hyprland
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      cosmic.default = [ "cosmic" "gtk" "*" ];
      common.default = [ "gtk" ];
      hyprland.default = [ "gtk" "hyprland" ];
    };
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-cosmic ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "com.system76.CosmicFiles.desktop";
      "x-directory/normal" = "com.system76.CosmicFiles.desktop";
    };
  };

  xdg.configFile = {
    "electron-flags.conf" = {
      text = ''
        --enable-features=WaylandWindowDecorations
        --ozone-platform-hint=auto
      '';
    };
  };
}
