{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "MesloLGS NF";
    };
    theme = "Tokyo Night Storm";
  };
  
      shell.program = "${pkgs.zsh}/bin/zsh";
      window.opacity = 0.8;
      draw_bold_text_with_bright_colors = true;
      font = {
        size = 11;
        normal = {
          family = "MesloLGS NF";
          style = "Regular";
        };
        bold = {
          family = "MesloLGS NF";
          style = "Bold";
        };
        italic = {
          family = "MesloLGS NF";
          style = "Italic";
    };
  };
}
