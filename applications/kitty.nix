{ ... }:

{
  programs.kitty = {
    enable = true;
    extraConfig = ''
      font_features LilexNerdFontCompleteM-Light +isol -medi -fina -init
    '';
    font = {
      name = "Lilex Medium Font Complete Mono";
      size = 18;
    };
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };
    shellIntegration = {
      mode = "no-cursor";
      enableZshIntegration = true;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;

      background_opacity = "0.9";
      background_tint = "0.5";

      confirm_os_window_close = 0;

      # Tabs
      tab_bar_edge = "bottom";
      tab_bar_style = "slant";
      tab_bar_align = "left";

      # Colours !
      background = "#24283b";
      foreground = "#c0caf5";
      selection_background = "#364A82";
      selection_foreground = "#c0caf5";
      url_color = "#73daca";

      # Cursor!
      cursor = "#c0caf5";
      cursor_shape = "block";
      cursor_stop_blinking_after = "0.0";
      cursor_blink_interval = 1;

      # Tabs
      active_tab_background = "#7aa2f7";
      active_tab_foreground = "#1f2335";
      inactive_tab_background = "#292e42";
      inactive_tab_foreground = "#545c7e";

      # normal colours
      color0 = "#414868";
      color1 = "#f7768e";
      color2 = "#9ece6a";
      color3 = "#e0af68";
      color4 = "#7aa2f7";
      color5 = "#bb9af7";
      color6 = "#7dcfff";
      color7 = "#c0caf5";

      # bright
      color8 = "#414868";
      color9 = "#f7768e";
      color10 = "#9ece6a";
      color11 = "#e0af68";
      color12 = "#7aa2f7";
      color13 = "#bb9af7";
      color14 = "#7dcfff";
      color15 = "#a9b1d6";

      # extended colors
      color16 = "#ff9e64";
      color17 = "#db4b4b";
    };
  };
}
