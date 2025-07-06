{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-termfilechooser ];
  };
  services.flatpak = {
    enable = true;
  };
}
