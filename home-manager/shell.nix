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
  program.home-manager.enable = true;

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
  };

  

  # Shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [{ 
          name = "powerlevel10k";
          src = powerlevel10k;
        }];
    };
  };


}
