{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libva

    river
    rivercarro

    wayland-utils
    wayland

    wl-clipboard

    xwayland
  ];

  services.xserver.displayManager = {
    sessionPackages = [
      (pkgs.river.overrideAttrs
        (prevAttrs: {
          postInstall = 
            let 
              riverSession = ''
                [Desktop Entry]
                Name=River
                Comment=Dynamic Wayland compositor
                Exec=river
                Type=Application
              '';
            in
              ''
                mkdir -p $out/share/wayland-sessions
                echo "${riverSession}" > $out/share/wayland-sessions/river.desktop
              '';
          passthru.providedSessions = [ "river" ];
        })
      )
    ];
  };

  # Holy shit wlroots, are you serious ?!
  environment.sessionVariables = {
    __GLX_VENDOR_LIBRARY_NAME           = "nvidia";
    LIBVA_DRIVER_NAME                   = "nvidia";
    GBM_BACKEND                         = "nvidia-drm";

    # XDG_SESSION_TYPE                    = "wayland";
    XDG_SESSION_DESKTOP                 = "river";
    XDG_CURRENT_DESKTOP                 = "river";

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
    WLR_BACKEND                         = "eglstream";
  };
}