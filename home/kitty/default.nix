{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    font = {
      name = "Lilex Nerd Font Mono Regular";
      size = if pkgs.stdenvNoCC.isDarwin then 24 else 18;
    };
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };
    shellIntegration = {
      mode = "no-cursor";
      enableZshIntegration = true;
    };
    theme = "Tokyo Night Storm";
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;

      background_opacity = "0.9";
      background_tint = "0.5";

      confirm_os_window_close = 0;
      hide_window_decorations = "titlebar-only";

      # Tabs
      tab_bar_edge = "bottom";
      tab_bar_style = "slant";
      tab_bar_align = "left";

      # Cursor!
      cursor_shape = "block";
      cursor_blink_interval = 0;
    };
  };
}
