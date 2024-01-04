_:
{
  home.stateVersion = "23.11";
  xdg.enable = true;

  imports = [
    ../../home/stylix

    # Wayland ?
    # ../../home/wayland/river
    ../../home/wayland/hyprland
    # ../../home/anyrun # now that ags works, maybe i don't need this anymore.
    ../../home/ags

    # x11 aka. xmonad in my case
    ../../home/x11

    ../../home/kitty

    ../../home/shells/zsh

    ../../home/editors/helix
    # ../../home/editors/neovim

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
