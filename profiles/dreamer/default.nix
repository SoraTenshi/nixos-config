_:
let asPath = paths: map (path: ../../home + "/${path}") paths;
in {
  home.stateVersion = "23.11";
  xdg.enable = true;

  imports = asPath [
    "stylix"

    "ags"
    "binary-ninja"
    "cli-tools"
    "development"
    "dunst"
    "ghostty"
    "gtk-theme"
    "guix"
    "kitty"
    "lazygit"
    "newsboat"
    "spotify"
    "spotify-player"
    "user-apps"
    "virtual"

    "editors/helix"
    "shells/zsh"
    "wayland/hyprland"
  ];
}
