{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libva

    wl-clipboard

    wayland
    wayland-utils

    xwayland
  ];

  # Holy shit wlroots, are you serious ?!
  environment.sessionVariables = {
    __GLX_VENDOR_LIBRARY_NAME           = "nvidia";
    LIBVA_DRIVER_NAME                   = "nvidia";
    GBM_BACKEND                         = "nvidia-drm";

    # XDG_SESSION_TYPE                    = "wayland";

    CLUTTER_BACKEND                     = "wayland";
    SDL_VIDEODRIVER                     = "wayland";
    # QT_QPA_PLATFORM                     = "wayland"; # SDDM says no to this

    __GL_GSYNC_ALLOWED                  = "0";
    __GL_VRR_ALLOWED                    = "0";
    __GL_MAXFRAMESALLOWED               = "1";

    _JAVA_AWT_WM_NONREPARENTING         = "1";
    NO_AT_BRIDGE                        = "1";
    MOZ_ENABLE_WAYLAND                  = "1";
    WLR_NO_HARDWARE_CURSORS             = "1";
    KITTY_ENABLE_WAYLAND                = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    WLR_DRM_DEVICES                     = "/dev/dri/card1:/dev/dri/card0";
    # WLR_BACKEND                         = "eglstream";
  };
}
