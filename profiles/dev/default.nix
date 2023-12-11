_:
{
  home.stateVersion = "23.11";
  xdg.enable = true;

  imports = [
    ../../home/stylix

    ../../home/ags
    ../../home/wayland/hyprland

    ../../home/x11

    ../../home/kitty

    ../../home/shells/zsh

    ../../home/editors/helix

    ../../home/cli-tools
    ../../home/lazygit
    ../../home/newsboat
    ../../home/dunst
    ../../home/email
    ../../home/work-specific
    
    ../../home/spotify
    ../../home/user-apps

    ../../home/development
  ];
}
