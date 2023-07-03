{ ... }:
{
  home.stateVersion = "23.05";
  xdg.enable = true;

  imports = [
    ../../home/graphical-tools/river

    ../../home/x11

    ../../home/kitty

    ../../home/shells/zsh

    ../../home/editors/helix
    ../../home/editors/neovim

    ../../home/cli-tools
    ../../home/lazygit
    ../../home/newsboat
    ../../home/dunst
    
    ../../home/nyxt
    ../../home/spotify

    ../../home/development
  ];
}
