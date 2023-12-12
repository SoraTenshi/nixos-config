{ config, monitors, grab-workspace, pkgs, username, ... }:

let 
  cursor = config.home.pointerCursor;
  terminal = "kitty";
  other-terminal = "/home/${username}/.local/bin/ghostty";
  keys = ["1" "2" "3" "4" "5" "6" "7" "8" "9"];

  zipWith = f: xs: ys:
    if xs == [] || ys == [] then []
    else [ (f (builtins.head xs) (builtins.head ys)) ] ++ zipWith f (builtins.tail xs) (builtins.tail ys);

  each-bar = i: "layerrule=blur,bar-${builtins.toString i}\nlayerrule=ignorezero,bar-${builtins.toString i}\nlayerrule=xray[1], ${builtins.toString i}";
  as-monitor = s: "monitor=${s},1";
  workspaces = ws: "workspace = ${ws}, persistent:true, default:true"; 
  workspaceChange = ws: nr: "SUPER, ${nr}, grab-workspace, ${ws}";
  workspaceMove = ws: nr: "SUPERSHIFT, ${nr}, movetoworkspacesilent, name:${ws}";
in
{
  programs.swaylock.enable = true;

  home.packages = [
    pkgs.swww
    pkgs.wdisplays
    pkgs.grim
    pkgs.slurp
    pkgs.xdg-desktop-portal-hyprland
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    plugins = [
      "${grab-workspace.packages."x86_64-linux".default}/lib/libgrab-workspace.so"
    ];

    settings = {
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      bind = [
        #### Execute apps ####
        "SUPERSHIFT, D, exec, discordcanary --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime"
        "SUPERSHIFT, RETURN, exec, ${terminal}"
        "SUPER, RETURN, exec, ${other-terminal}"
        # "SUPER, P, exec, anyrun"
        "SUPER, P, exec, ags -r \"BarState.value = 'app-launcher $(($(hyprctl monitors | grep 'focused' | grep -n 'yes' | cut -c1)-1))';\""
        "CONTROL, PRINT, exec, grim -g \"$(slurp)\" - | wl-copy"
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
      (zipWith workspaceChange keys keys)
      ++
      #### Move to workspace ####
      (zipWith workspaceMove keys keys);

      exec-once = [
        "hyprctl setcursor ${cursor.name} ${toString cursor.size}"
        "ags"
        "fcitx5"
        "swww init"
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

      animations = {
        enabled = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };
    };
    extraConfig = ''
      windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
      windowrulev2 = noanim,class:^(xwaylandvideobridge)$
      windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
      windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$
      ${builtins.concatStringsSep "\n" (builtins.map workspaces keys)}
      ${builtins.concatStringsSep "\n" (builtins.map as-monitor monitors)}
      ${builtins.concatStringsSep "\n" (
        builtins.map 
          each-bar 
          (builtins.genList (i: i) (builtins.length monitors))
      )}
    '';
  };
}
