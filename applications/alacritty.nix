{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  # Terminal Emulator
  programs.alacritty = {
    enable = true;
    # When alacritty config done, get from github repo and integrate~
    settings = {
      shell.program = "${pkgs.zsh}/bin/zsh";
      window.opacity = 0.9;
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
      # Tokyo Night Storm colours
      colors = {
        primary = {
          background = "0x24283b";
          foreground = "0xa9b1d6";
        };
        normal = {
          black =  "0x32344a";
          red =    "0xf7768e";
          green =  "0x9ece6a";
          yellow = "0xe0af68";
          blue =   "0x7aa2f7";
          magenta ="0xad8ee6";
          cyan =   "0x449dab";
          white =  "0x9699a8";
        };
        bright = {
          black = "0x444b6a";
          red = "0xff7a93";
          green = "0xb9f27c";
          yellow = "0xff9e64";
          blue = "0x7da6ff";
          magenta = "0xbb9af7";
          cyan = "0x0db9d7";
          white = "0xacb0d0";
        };
        dim = {
          black = "0x444b6a";
          red = "0xff7a93";
          green = "0xb9f27c";
          yellow = "0xff9e64";
          blue = "0x7da6ff";
          magenta = "0xbb9af7";
          cyan = "0x0db9d7";
          white = "0xacb0d0";
        };
      };
    };
  };
}
