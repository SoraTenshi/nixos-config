_:
let asPath = paths: map (path: ../../home + "/${path}") paths;
in {
  home.stateVersion = "23.11";
  xdg.enable = true;

  imports = asPath [
    "stylix"

    "ags"
    "cli-tools"
    "development"
    "dunst"
    "gtk-theme"
    "guix"
    "kitty"
    "lazygit"
    "newsboat"
    "spotify"
    "user-apps"
    "virtual"

    "editors/helix"
    "shells/zsh"
    "wayland/hyprland"
  ];
}
