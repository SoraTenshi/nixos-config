{ monitors, lib, autostart, ... }:
let
  keys = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" ];

  each-bar = i: [
    "blur, bar-${builtins.toString i}"
    "ignorezero, bar-${builtins.toString i}"
    "xray 1, ${builtins.toString i}"
  ];
  as-monitor = s: [ "${s},1" ];
  workspaces = ws: [ "${ws}, persistent:true, default:true" ];
in {
  wayland.windowManager.hyprland.settings = {
    misc = {
      disable_autoreload = true;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      animate_mouse_windowdragging = false;
    };

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
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

      allow_tearing = true;
    };

    decoration = {
      rounding = 0;
      shadow = lib.mkForce {};
      blur = {
        enabled = true;
        ignore_opacity = false;
        passes = 2;
        size = 16;
        new_optimizations = true;
        popups = true;
        vibrancy = 0.1;
      };
    };

    cursor = {
      no_hardware_cursors = true;
      enable_hyprcursor = true;
      hide_on_touch = true;
    };

    animations = { enabled = false; };
    debug = { disable_logs = false; };
    xwayland = { force_zero_scaling = true; };

    windowrulev2 = [
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"
      "rounding 0, xwayland:1"

      "opacity 1.0 override,tag:fuzzel"

      # Smart Gaps
      "bordersize 1,floating:0,onworkspace:w[tv1]"
      "rounding 0,floating:0,onworkspace:w[tv1]"
      "bordersize 1,floating:0,onworkspace:f[1]"
      "rounding 0,floating:0,onworkspace:f[1]"
    ];

    exec-once = autostart;

    workspace = (builtins.concatMap workspaces keys) ++ [
      # Smart gaps
      "w[tv1],gapsout:0,gapsin:0"
      "f[1],gapsout:0,gapsin:0"
    ];

    monitor = builtins.concatMap as-monitor monitors;
    layerrule = (builtins.concatMap each-bar
      (builtins.genList (i: i) (builtins.length monitors))) ++ [
        "blur,gtk-layer-shell"
        # "blurpopups,gtk-layer-shell"
      ];
  };
}
