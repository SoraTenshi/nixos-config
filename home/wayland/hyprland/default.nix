{ self, config, monitors, pkgs, username, ... }:
let
  cursor = config.home.pointerCursor;
  terminal = "kitty";
  other-terminal = "/home/${username}/.local/bin/ghostty";
  keys = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" ];

  zipWith = f: xs: ys:
    if xs == [ ] || ys == [ ] then
      [ ]
    else
      [ (f (builtins.head xs) (builtins.head ys)) ]
      ++ zipWith f (builtins.tail xs) (builtins.tail ys);

  each-bar = i: [
    "blur, bar-${builtins.toString i}"
    "ignorezero, bar-${builtins.toString i}"
    "xray 1, ${builtins.toString i}"
  ];
  as-monitor = s: [ "${s},1" ];
  workspaces = ws: [ "${ws}, persistent:true, default:true" ];
  workspaceChange = ws: nr:
    "SUPER, ${nr}, focusworkspaceoncurrentmonitor, ${ws}";
  workspaceMove = ws: nr:
    "SUPERSHIFT, ${nr}, movetoworkspacesilent, name:${ws}";
in {
  home.packages = [
    pkgs.swappy
    pkgs.wdisplays
    pkgs.grim
    pkgs.slurp
    pkgs.xwaylandvideobridge
    pkgs.qt6.qtwayland
    pkgs.libsForQt5.qt5.qtwayland
    pkgs.xdg-desktop-portal-hyprland
    pkgs.xdg-desktop-portal-gtk
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal ];
    configPackages = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  programs.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = "${self}/images";
        duration = "10m";
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      bindm =
        [ "SUPER, mouse:272, movewindow" "SUPER, mouse:273, resizewindow" ];

      bind = [
        #### Execute apps ####
        "SUPERSHIFT, D, exec, discord --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime"
        "SUPERSHIFT, RETURN, exec, ${terminal}"
        "SUPER, RETURN, exec, ${other-terminal}"
        ''
          SUPERSHIFT, P, exec, ags -r "BarState.value = 'shutdown $(($(hyprctl monitors | grep 'focused' | grep -n 'yes' | cut -c1)-1))';"''
        ''
          SUPER, X, exec, ags -r "BarState.value = 'executor $(($(hyprctl monitors | grep 'focused' | grep -n 'yes' | cut -c1)-1))';"''
        ''
          SUPER, P, exec, ags -r "BarState.value = 'app-launcher $(($(hyprctl monitors | grep 'focused' | grep -n 'yes' | cut -c1)-1))';"''
        ''CONTROL, PRINT, exec, grim -g "$(slurp)" - | wl-copy''
        ''SHIFTCONTROL, PRINT, exec, grim -g "$(slurp)" - | swappy -f - ''
        "SUPERSHIFTCONTROL, L, exec, waylock -init-color 0x24283b -input-color 0xbb9af7 -fail-color 0xf7768e"
        "SUPERSHIFTCONTROL, Q, exit"
        # "SUPER, P, exec, dmenu_run -l 15 -fn 'Lilex Nerd Font-16' -nb '#24283b' -nf '#a9b1d6' -sb '#414868' -sf '#7aa2f7' -p '-> '"
        # "SUPER, N, exec, networkmanager_dmenu -l 15 -fn 'Lilex Nerd Font-16' -nb '#24283b' -nf '#a9b1d6' -sb '#414868' -sf '#7aa2f7'"

        #### Controls ####
        "SUPERSHIFT, Q, killactive"
        "SUPER, F, fullscreen"
        "SUPER, T, togglefloating"
        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"
        "SUPERSHIFT, H, resizeactive, -100 0"
        "SUPERSHIFT, L, resizeactive, 100 0"
        "SUPERSHIFT, K, resizeactive, 0 100"
        "SUPERSHIFT, J, resizeactive, 0 -100"

        #### Multi Monitor stuff ####
        "SUPER, bracketleft, focusmonitor, l"
        "SUPER, bracketright, focusmonitor, r"
      ] ++
        #### Change workspace ####
        (zipWith workspaceChange keys keys) ++
        #### Move to workspace ####
        (zipWith workspaceMove keys keys);

      exec-once = [
        "hyprctl setcursor ${cursor.name} ${toString cursor.size}"
        "ags"
        "fcitx5 -d --replace"
        "wpaperd"
        "xwaylandvideobridge"
      ];

      misc = {
        disable_autoreload = false;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        animate_mouse_windowdragging = false;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };

      input = {
        kb_layout = "eu";
        kb_options = "compose:ralt";
        repeat_rate = 60;
        follow_mouse = 1;
        numlock_by_default = true;
        accel_profile = "flat";
        scroll_method = "2fg";
        natural_scroll = false;
        scroll_button = 274;
        scroll_button_lock = true;
        touchpad = {
          scroll_factor = 0.3;
          natural_scroll = true;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 5;
        no_cursor_warps = true;
      };

      decoration = {
        rounding = 0;
        drop_shadow = false;
        blur = {
          enabled = true;
          size = 10;
          new_optimizations = true;
          xray = true;
          vibrancy = 0.1;
        };
      };

      animations = { enabled = true; };

      xwayland = { force_zero_scaling = true; };

      windowrulev2 = [
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "rounding 0, xwayland:1"
      ];

      workspace = builtins.concatMap workspaces keys;
      monitor = builtins.concatMap as-monitor monitors;
      layerrule = builtins.concatMap each-bar
        (builtins.genList (i: i) (builtins.length monitors));
    };
  };
}
