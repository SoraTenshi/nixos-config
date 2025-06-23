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
    "email"
    "flatpak"
    "fuzzel"
    "ghostty"
    "gtk-theme"
    "guix"
    "jj"
    "kitty"
    "lazygit"
    "newsboat"
    "seto"
    "spicetify"
    # "spotify"
    "spotify-player"
    "user-apps"
    "work-specific"

    "editors/emacs"
    "editors/helix"
    "shells/schemesh"
    "shells/zsh"
    "wayland/hyprland"
  ];
}
