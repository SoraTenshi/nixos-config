# Used for the configuration of specific configurations

{ config, pkgs, ... }:

let 
  cyberpunk-neon = pkgs.fetchFromGitHub {
    owner = "roboron3042";
    repo = "cyberpunk-neon";
    rev = "4dbd5b382e9af6b501843df25577babe071fad87";
    sha256 = "0yrv37ssqrwmls5r2icf1c2j4j9z2m79c7k2xag0k4c93cl7z4ly";
  };
in
{
  # Enable the usage of home-manager
  # The point of home-manager is to create
  # symlinks from /nix/store
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Terminal Emulator
    alacritty
    
    # Actual Shell, with some skins
    zsh
  ];

  # Let's start and use Cyberpunk-neon

  # Terminal Emulator
  programs.alacritty = {
    enable = true;
    # When alacritty config done, get from github repo and integrate~
    settings = {
      shell.program = "${pkgs.zsh}/bin/zsh";
      background_opacity = 0.9;
      draw_bold_text_with_bright_colors = true;
      font = {
        size = 11;
        normal = {
          family = "JetBrains Mono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrains Mono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrains Mono Nerd Font";
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

  # Shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellGlobalAliases = {
      vim = "spacevim ";
      sudo = "sudo ";
      cat = "bat ";
    };

    shellAliases = {
      vim = "spacevim ";
      sudo = "sudo ";
      cat = "bat ";
    };

    plugins = [{
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
    # {
    #   name = "cyberpunk-neon";
    #   src = "${cyberpunk-neon}/terminal/zsh/powerlevel9k/";
    #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    # }
  ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" "sudo" "man" "rust"
      ];
    };
  };
}
