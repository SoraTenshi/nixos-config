_:
{
  home.stateVersion = "23.05";
  xdg.enable = true;

  imports = [
    ../../home/stylix

    # Wayland ?
    ../../home/wayland/river
    ../../home/wayland/hyprland
    ../../home/anyrun
    ../../home/ags

    # x11 aka. xmonad in my case
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
    ../../home/user-apps

    ../../home/development
  ];
}
