{ ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require "wezterm"
      
      return {
        font = wezterm.font_with_fallback({ "Lilex Light Nerd Font Complete Mono", }, {
          weight = "Light",
        }),
        font_size = 18
        color_scheme = "tokyonight-storm"
        enable_scroll_bar = false
        use_fancy_tab_bar = false
        enable_tab_bar = true
        scrollback_lines = 10000,
        window_padding = {
          left = 15,
          right = 15,
          top = 15,
          bottom = 15,
        },
        check_for_updates = false,
        default_cursor_style = "BlinkingBlock",
        animation_fps = 15,
      }
    '';
  };
}
