_:
let asPath = paths: map (path: ../../home + "/${path}") paths;
in {
  home.stateVersion = "24.05";
  xdg.enable = true;

  imports = asPath [
    "stylix"

    "ags"
    "anki"
    "cli-tools"
    "development"
    "dunst"
    "editors/emacs"
    "email"
    "ghostty"
    "gtk-theme"
    "guix"
    "jj"
    "kitty"
    "lazygit"
    "newsboat"
    "seto"
    "shells/zsh"
    "spicetify"
    # "spotify"
    "spotify-player"
    "user-apps"
    "work-specific"

    "editors/helix"
    "wayland/hyprland"
  ];
}
