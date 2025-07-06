{ inputs, pkgs, lib, ... }: {
  imports = [ ./settings.nix ./binds.nix ];

  home.packages = [
    pkgs.swappy
    pkgs.wdisplays
    pkgs.grim
    pkgs.slurp
    pkgs.qt6.qtwayland
    pkgs.libsForQt5.qt5.qtwayland
    pkgs.hyprcursor
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [ "gtk" "hyprland" ];
    };

    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        monitor = "";
        path = lib.mkForce "screenshot";
        color = lib.mkForce "rgb(24283b)";
        blur_passes = 2;
        blur_size = 10;
        noise = "0.0117";
        brightness = "0.8172";
      };
    };
  };

  services.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = "${inputs.self}/images";
        duration = "10m";
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd = {
      enable = true;
      variables = [ "--all" ];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
    xwayland.enable = true;

    settings = {
      exec-once = [
        "ags"
        "fcitx5-remote -r"
        "fcitx5 -d --replace"
        "wpaperd"
      ];
    };
  };
}
