{ monitors, ... }:
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

      allow_tearing = true;
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
    debug = { disable_logs = false; };
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
}
