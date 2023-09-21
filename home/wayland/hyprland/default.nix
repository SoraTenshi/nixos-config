{ nix-colors, ... }:

let 
  color = nix-colors.colorSchemes.tokyo-night-storm;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    # settings = ''' 
    # exec-once = systemctl --user start clight
    # exec-once = eww open bar

    # xwayland {
    #   force_zero_scaling = true
    # }

    # misc {
    #   disable_autoreload = true

    #   disable_hyprland_logo = true
    #   disable_splash_rendering = true
    #   animate_mouse_windowdragging = false
    #   vrr = 1

    #   groupbar_titles_font_size = 16
    #   groupbar_gradients = false
    # }

    # gestures {
    #   workspace_swipe = true
    #   workspace_swipe_forever = true
    # }

    # input {
    #   kb_layout = eu

    #   follow_mouse = 1
    #   accel_profile = flat
    #   touchpad {
    #     scroll_factor = 0.3
    #   }
    # }
    
    # general {
    #   gaps_in = 5
    #   gaps_out = 5
    #   border_size = 1
    #   col.active_border = rgba(88888888)
    #   col.inactive_border = rgba(00000088)

    #   col.group_border_active = rgba(${color.pink}88)
    #   col.group_border = rgba(${color.surface0}88)
    # }

    # decoration {
    #   rounding = 16
    #   blur {
    #     enabled = true
    #     size = 10
    #     passes = 3
    #     new_optimizations = true
    #     brightness = 1.0
    #     noise = 0.02
    #   }

    #   drop_shadow = true
    #   shadow_ignore_window = true
    #   shadow_offset = 0 2
    #   shadow_range = 20
    #   shadow_render_power = 3
    #   col.shadow = rgba(00000055)
    # }
    # ''';
  };
}
