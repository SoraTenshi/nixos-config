{ pkgs, ... }: {
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
    nvidia-vaapi-driver

    wl-clipboard

    wayland
    wayland-utils

    xwayland

    waylock
  ];

  # Holy shit wlroots, are you serious ?!
  programs.hyprland.enable = true;
  environment.sessionVariables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    XMODIFIERS = "@im=fcitx";
    NIXOS_OZONE_WL = "1";

    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";

    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    __GL_MAXFRAMESALLOWED = "1";

    _JAVA_AWT_WM_NONREPARENTING = "1";
    NO_AT_BRIDGE = "1";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    # WLR_NO_HARDWARE_CURSORS = "1";
    KITTY_ENABLE_WAYLAND = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    WLR_BACKEND = "eglstream";
  };
}
