_:
let asPath = paths: map (path: ../../home + "/${path}") paths;
in {
  home.stateVersion = "23.11";
  xdg.enable = true;

  imports = asPath [
    "stylix"

    "ags"
    "anki"
    # "binary-ninja"
    "cli-tools"
    "development"
    "dunst"
    "ghostty"
    "gtk-theme"
    "guix"
    # "kitty"
    # "lazygit"
    "jj"
    "newsboat"
    "spotify"
    "spotify-player"
    "user-apps"
    "virtual"

    "editors/emacs"
    "editors/helix"
    "shells/zsh"
    "wayland/hyprland"
  ];
}
