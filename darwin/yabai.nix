{ ... }:
{
  services.yabai = {
    enable = true;
    config = {
      layout = "bsp";
      auto_balance = "off";
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      top_padding = "6";
      bottom_padding = "52";
      left_padding = "6";
      right_padding = "6";
      window_gap = "6";
      active_window_border = "#7dcfff";
      normal_window_border = "#24283b";
    };
    extraConfig = ''
      .blacklist {
        "League Of Legends"
      }

      yabai -m rule --add title='Preferences' manage=off layer=above
      yabai -m rule --add title='^(Opening)' manage=off layer=above
      yabai -m rule --add title='Library' manage=off layer=above
      yabai -m rule --add app='^System Preferences$' manage=off layer=above
      yabai -m rule --add app='Activity Monitor' manage=off layer=above
      yabai -m rule --add app='Finder' manage=off layer=above
      yabai -m rule --add app='^System Information$' manage=off layer=above
    '';
  };
}
