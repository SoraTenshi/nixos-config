{ config, ... }:

let 
  cursor = config.home.pointerCursor;
  terminal = "kitty";
  other-terminal = "/home/dreamer/.local/bin/ghostty";
  workspaces = ["一" "二" "三" "四" "五" "六" "七" "八" "九"];
  keys = [1 2 3 4 5 6 7 8 9];

  zipWith = f: xs: ys:
    if xs == [] || ys == [] then []
    else [ (f (builtins.head xs) (builtins.head ys)) ] ++ zipWith f (builtins.tail xs) (builtins.tail ys);

  workspaceChange = ws: nr: "SUPER, ${builtins.toString nr}, workspace, name:${ws}";
  workspaceMove = ws: nr: "SUPERSHIFT, ${builtins.toString nr}, movetoworkspacesilent, name:${ws}";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    systemd.enable = true;
    xwayland.enable = true;
    settings = {
      "$pavucontrol" = "class:^(pavucontrol)$";

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      bind = [
        #### Execute apps ####
        "SUPERSHIFT, RETURN, exec, ${terminal}"
        "SUPER, RETURN, exec, ${other-terminal}"
        "SUPER, P, exec, fuzzel"

        #### Controls ####
        "SUPERSHIFT, Q, killactive"
        "SUPER, F, fullscreen"
        "SUPER, T, togglefloating"
        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"
        "SUPERSHIFT, H, resizeactive, -40 0"
        "SUPERSHIFT, L, resizeactive, 40 0"
        "SUPERSHIFT, K, resizeactive, 0 40"
        "SUPERSHIFT, J, resizeactive, 0 -40"

        #### Multi Monitor stuff ####
        "SUPERSHIFT, bracketleft, focusmonitor, l"
        "SUPERSHIFT, bracketright, focusmonitor, r"
      ] ++ 
      #### Change workspace ####
      (zipWith workspaceChange workspaces keys)
      ++
      #### Move to workspace ####
      (zipWith workspaceMove workspaces keys);

      exec-once = [
        "hyprctl setcursor ${cursor.name} ${toString cursor.size}"

        # "eww open bar"
      ];

      misc = {
        disable_autoreload = false;
        disable_hyprland_logo = false;
        disable_splash_rendering = true;
        animate_mouse_windowdragging = false;
        # groupbar_titles_font_size = 16;
        # groupbar_gradients = false;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };

      input = {
        kb_layout = "eu";
        kb_options = "compose:ralt";
        follow_mouse = 1;
        numlock_by_default = true;
        accel_profile = "flat";
        scroll_method = "2fg";
        natural_scroll = false; # this also is there on mouse ;/
        touchpad = {
          scroll_factor = 0.3;
        };
      };
    
      general = {
        gaps_in = 5;
        gaps_out = 5;
        layout = "master";
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

      animations = {
        enabled = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

    };
  };
}
