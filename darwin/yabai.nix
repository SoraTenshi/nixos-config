{ ... }:
{
  services.yabai = {
    enable = true;
    config = {
      layout = "bsp";
      auto_balance = "off";
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      top_padding = "6";
      bottom_padding = "52";
      left_padding = "6";
      right_padding = "6";
      window_gap = "6";
      window_shadow = "float";
      window_topmost = "on";
      active_window_border = "0xff7dcfff";
      normal_window_border = "0xff24283b";
    };
    extraConfig = ''
      .blacklist {
        "League Of Legends"
      }

      yabai -m rule --add title='Settings' manage=off layer=above
      yabai -m rule --add title='Preferences' manage=off layer=above
      yabai -m rule --add title='^(Opening)' manage=off layer=above
      yabai -m rule --add title='Library' manage=off layer=above
      yabai -m rule --add app='^System Settings$' manage=off layer=above
      yabai -m rule --add app='Activity Monitor' manage=off layer=above
      yabai -m rule --add app='Finder' manage=off layer=above
      yabai -m rule --add app='^System Information$' manage=off layer=above
    '';
  };
}
