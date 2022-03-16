{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  # Terminal Emulator
  programs.alacritty = {
    enable = true;
    # When alacritty config done, get from github repo and integrate~
    settings = {
      shell.program = "${pkgs.zsh}/bin/zsh";
      window.opacity = 0.3;
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
      env = {
        LANG = "en_US.UTF-8";
        LC_CTYPE = "en_US.UTF-8";
      };
      colors = {
        primary = {
          background = "0x000b1e";
          foreground = "0x0abdc6";
        };
        normal = {
          black = "0x123e7c";
          red = "0xff0000";
          green = "0xd300c4";
          yellow = "0xf57800";
          blue = "0x123e7c";
          magenta = "0x711c91";
          cyan = "0x0abdc6";
          white = "0xd7d7d5";
        };
        bright = {
          black = "0x1c61c2";
          red = "0xff0000";
          green = "0xd300c4";
          yellow = "0xf57800";
          blue = "0x00ff00";
          magenta = "0x711c91";
          cyan = "0x0abdc6";
          white = "0xd7d7d5";
        };
        dim = {
          black = "0x1c61c2";
          red = "0xff0000";
          green = "0xd300c4";
          yellow = "0xf57800";
          blue = "0x123e7c";
          magenta = "0x711c91";
          cyan = "0x0abdc6";
          white = "0xd7d7d5";
        };
      };
    };
  };


}
