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
    "fuzzel"
    "ghostty"
    "gtk-theme"
    "guix"
    "input-leap"
    "jj"
    "kitty"
    "lazygit"
    # "lem"
    "newsboat"
    "spicetify"
    # "spotify"
    "spotify-player"
    "user-apps"
    "weechat"
    "work-specific"

    "editors/emacs"
    "editors/helix"
    "shells/schemesh"
    "shells/zsh"
    "wayland/hyprland"
  ];
}
