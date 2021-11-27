# Used for the configuration of specific configurations

{ config, pkgs, ... }:

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
      plugins = [
        "git" "powerlevel10k"
      ];
    };
  };


}
