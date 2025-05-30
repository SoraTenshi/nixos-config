{ pkgs, ... }: 
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    config = {
      common.default = [ "gtk" ];
      hyprland.default = [ "gtk" "hyprland" ];
    };

    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  security.pam.services = { waylock = { unixAuth = true; }; };

  services.gvfs.enable = true;
  environment.systemPackages = with pkgs; [
    libva

    wl-clipboard

    wayland
    wayland-utils

    xwayland

    waylock
  ];

  # lol?
  services.desktopManager.cosmic = {
    enable = true;
    xwayland.enable = true;
  };

  programs.hyprland.enable = true;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GDK_DEBUG = "gl-disable-gles";

    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";

    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    __GL_MAXFRAMESALLOWED = "1";

    _JAVA_AWT_WM_NONREPARENTING = "1";
    NO_AT_BRIDGE = "1";
    MOZ_ENABLE_WAYLAND = "1";
    KITTY_ENABLE_WAYLAND = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };
}
