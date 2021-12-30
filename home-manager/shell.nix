# Used for the configuration of specific configurations

{ config, pkgs, ... }:

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

    # Shell utils
    bat
  ];

  # Terminal Emulator
  programs.alacritty = {
    enable = true;
    # When alacritty config done, get from github repo and integrate~
    settings = {
      shell.program = "${pkgs.zsh}/bin/zsh";
      background_opacity = 0.6;
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

  # Shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    # enableSyntaxHighlighting = true;

    # this needs some work, the colourscheme fits, but i dislike the design
    initExtra = ''
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';

    shellGlobalAliases = {
      vim = "nvim ";
      sudo = "sudo ";
      cat = "bat ";
    };

    shellAliases = {
      vim = "nvim ";
      sudo = "sudo ";
      cat = "bat ";
    };

    plugins = [{
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" "sudo" "man" "rust"
      ];
    };
  };

  home.file = {
    ".p10k.zsh" = {
      source = let
        repo = pkgs.fetchFromGitHub {
          owner  =  "s0la1337";
          repo   =  "dotfiles";
          rev    =  "81dfe16c977ed296b8466e7e528281ff33aaa464";
          sha256 =  "145538jm473ygm5paxmikzs1z98qj4lswm6iild8cpv0w31lk55h";
        };
      in "${repo}/powerlevel10k/.p10k.zsh";
    };
  };
}
