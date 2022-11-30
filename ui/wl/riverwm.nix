{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libva

    # libsForQt5.qt5.qtwayland

    river
    rivercarro

    wayland-utils
    wayland

    wl-clipboard

    xwayland
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  services.pipewire = {
    audio.enable = true;
    systemWide = true;
  };
  
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

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    XDG_SESSION_DESKTOP = "river";
    XDG_CURRENT_DESKTOP = "river";
    MOZ_ENABLE_WAYLAND = "1";
    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NO_AT_BRIDGE = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
