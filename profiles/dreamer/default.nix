{ ... }:
{
  home.stateVersion = "23.05";
  manual.manpages.enable = false;

  xdg.enable = true;

  imports = [
    # ui
    ../../ui/x11/xmonad.nix

    # wl
    ../../ui/wl/tools.nix

    # Editor stuff
    ../../home/shells/zsh
    ../../home/editors/helix
    ../../home/editors/neovim

    # General purpose
    ../../home/lazygit
    ../../home/cli-tools
    ../../home/newsboat
    ../../home/dunst
    
    # User applications
    ../../home/nyxt
    ../../home/kitty
    ../../home/spotify

    # development
    ../../home/development
  ];
}
