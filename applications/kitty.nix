{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "MesloLGS NF";
      size = 18;
    };
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      
      background_opacity = "0.9";
      
      # Tabs
      tab_bar_edge = "bottom";
      tab_bar_style = "fade";
      tab_bar_align = "center";
    };
    theme = "Tokyo Night Storm";
  };
  
  #     shell.program = "${pkgs.zsh}/bin/zsh";
  #     window.opacity = 0.8;
  #     draw_bold_text_with_bright_colors = true;
  #     font = {
  #       size = 11;
  #       normal = {
  #         family = "MesloLGS NF";
  #         style = "Regular";
  #       };
  #       bold = {
  #         family = "MesloLGS NF";
  #         style = "Bold";
  #       };
  #       italic = {
  #         family = "MesloLGS NF";
  #         style = "Italic";
  #   };
  # };
}
