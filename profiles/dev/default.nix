_:
let asPath = paths: map (path: ../../home + "/${path}") paths;
in {
  home.stateVersion = "24.05";
  xdg.enable = true;

  imports = asPath [
    "stylix"

    "ags"
    "cli-tools"
    "development"
    "dunst"
    "email"
    "gtk-theme"
    "kitty"
    "lazygit"
    "newsboat"
    "shells/zsh"
    "spotify"
    "user-apps"
    "work-specific"

    "editors/helix"
    "wayland/hyprland"
  ];
}
