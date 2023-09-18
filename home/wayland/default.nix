{ nix-colors, ... }:

let 
  color = nix-colors.colorSchemes.tokyo-night-storm;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    settings = ''' 
    
    exec-once = systemctl --user start clight
    exec-once = eww open bar

    # use this instead of hidpi patches
    xwayland {
      force_zero_scaling = true
    }

    misc {
      # disable auto polling for config file changes
      disable_autoreload = true

      disable_hyprland_logo = true
      disable_splash_rendering = true

      # disable dragging animation
      animate_mouse_windowdragging = false

      # enable variable refresh rate (effective depending on hardware)
      vrr = 1

      # groupbar
      groupbar_titles_font_size = 16
      groupbar_gradients = false
    }

    # touchpad gestures
    gestures {
      workspace_swipe = true
      workspace_swipe_forever = true
    }

    input {
      kb_layout = eu

      # focus change on cursor move
      follow_mouse = 1
      accel_profile = flat
      touchpad {
        scroll_factor = 0.3
      }
    }
    
    general {
      gaps_in = 5
      gaps_out = 5
      border_size = 1
      col.active_border = rgba(88888888)
      col.inactive_border = rgba(00000088)

      # group borders
      col.group_border_active = rgba(${color.pink}88)
      col.group_border = rgba(${color.surface0}88)
    }

    decoration {
      rounding = 16
      blur {
        enabled = true
        size = 10
        passes = 3
        new_optimizations = true
        brightness = 1.0
        noise = 0.02
      }

      drop_shadow = true
      shadow_ignore_window = true
      shadow_offset = 0 2
      shadow_range = 20
      shadow_render_power = 3
      col.shadow = rgba(00000055)
    }

    ''';
  };
}
