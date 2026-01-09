_:
let asPath = paths: map (path: ../../home + "/${path}") paths;
in {
  home.stateVersion = "23.11";
  xdg.enable = true;

  imports = asPath [
    # "stylix"

    "ags"
    "anki"
    # "binary-ninja"
    "cli-tools"
    "development"
    "discord"
    "dunst"
    "fuzzel"
    "ghostty"
    "gtk-theme"
    "guix"
    # "kitty"
    # "lazygit"
    "jj"
    "newsboat"
    "steam"
    "spicetify"
    # "spotify"
    "spotify-player"
    "user-apps"
    "virtual"
    "weechat"

    "editors/emacs"
    "editors/helix"
    "shells/schemesh"
    "shells/zsh"
    "wayland/hyprland"
  ];
}
