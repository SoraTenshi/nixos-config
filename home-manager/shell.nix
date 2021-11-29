# Used for the configuration of specific configurations

{ config, pkgs, ... }:

let 
  powerlevel10k = pkgs.fetchFromGitHub {
    owner = "romkatv";
    repo = "powerlevel10k";
    rev = "a9f208c8fc509b9c591169dd9758c48ad4325f76";
    sha256 = "1jkddpmdmp274wkx407dwyi78dhraqq6vdxh15m13yraq1cy17jw";
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
    initExtra = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" "sudo" "man" "rust"
      ];
    };
  };

  home.file = {
    ".zshrc" = {
      source = let 
        repo = pkgs.fetchFromGitHub {
          owner = "roboron3042";
          repo = "cyberpunk-neon";
          rev = "4dbd5b382e9af6b501843df25577babe071fad87";
          sha256 = "0yrv37ssqrwmls5r2icf1c2j4j9z2m79c7k2xag0k4c93cl7z4ly";
        };
      in "${repo}/terminal/zsh/powerlevel9k";
    };
  };
}
