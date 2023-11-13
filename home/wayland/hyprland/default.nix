{ nix-colors, config, ... }:

let 
  color = nix-colors.colorSchemes.tokyo-night-storm;
  cursor = config.home.pointerCursor;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    systemd.enable = true;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      "$pavucontrol" = "class:^(pavucontrol)$";

      exec-once = [
        "hyprctl setcursor ${cursor.name} ${toString cursor.size}"

        # "eww open bar"
      ];

      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = false;
        disable_splash_rendering = true;
        animate_mouse_windowdragging = false;
        groupbar_titles_font_size = 16;
        groupbar_gradients = false;
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
        natural_scroll = true;
        touchpad = {
          scroll_factor = 0.3;
        };
      };
    
      general = {
        gaps_in = 5;
        gaps_out = 5;
        col = {
          active_border = "rgba(88888888)";
          inactive_border = "rgba(00000088)";
          group_border_active = "rgba(${color.pink}88)";
          group_border = "rgba(${color.surface0}88)";
        };
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
