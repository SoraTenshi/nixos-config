{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    eww-wayland

    dconf

    river

    wayland-utils
    wayland

    wofi

    xwayland
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
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
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "river";
    XDG_CURRENT_DESKTOP = "river";
    MOZ_ENABLE_WAYLAND = "1";
    CLUTTER_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland-egl";
    ECORE_EVAS_ENGINE = "wayland-egl";
    ELM_ENGINE = "wayland_egl";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NO_AT_BRIDGE = "1";
  };
}
