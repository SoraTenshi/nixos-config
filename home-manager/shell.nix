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
    zsh oh-my-zsh zsh-powerlevel10k zsh-autosuggestions
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    plugins = [{
      name = "oh-my-zsh";
      src = oh-my-zsh;
    }{
      name = "powerlevel10k";
      src = zsh-powerlevel10k;
    }{
      name = "autosuggestions";
      src = zsh-autosuggestions;
    }];
  };


}
