{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = with pkgs.gnomeExtensions; [
    material-shell
    appindicator
    gnome-settings-daemon
    brightness-control-using-ddcutil
  ];
}
