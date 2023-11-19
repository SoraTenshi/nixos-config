{ config, pkgs, ... }:

let 
  cursor = config.home.pointerCursor;
  terminal = "kitty";
  other-terminal = "/home/dreamer/.local/bin/ghostty";
  keys = ["1" "2" "3" "4" "5" "6" "7" "8" "9"];

  zipWith = f: xs: ys:
    if xs == [] || ys == [] then []
    else [ (f (builtins.head xs) (builtins.head ys)) ] ++ zipWith f (builtins.tail xs) (builtins.tail ys);

  workspaces = ws: nr: "workspace = ${ws}, persistent:true"; 
  workspaceChange = ws: nr: "SUPER, ${nr}, workspace, name:${ws}";
  workspaceMove = ws: nr: "SUPERSHIFT, ${nr}, movetoworkspacesilent, name:${ws}";
in
{
  home.packages = [
    pkgs.wdisplays
  ];
  
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
        "SUPER, P, exec, anyrun"
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
        "SUPERSHIFT, bracketleft, focusmonitor, l"
        "SUPERSHIFT, bracketright, focusmonitor, r"
      ] ++ 
      #### Change workspace ####
      (zipWith workspaceChange keys keys)
      ++
      #### Move to workspace ####
      (zipWith workspaceMove keys keys);

      exec-once = [
        "hyprctl setcursor ${cursor.name} ${toString cursor.size}"
        "ags"
      ];

      misc = {
        disable_autoreload = false;
        disable_hyprland_logo = false;
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
        touchpad = {
          scroll_factor = 0.3;
          natural_scroll = true;
        };
      };
    
      general = {
        gaps_in = 5;
        gaps_out = 5;
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
    workspace = zipWith workspaces keys;
  };
}
