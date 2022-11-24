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

  xdg.portal.wlr.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd} --cmd river";
      };
    };
  };

  services.pipewire = {
    audio.enable = true;
    systemWide = true;
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
