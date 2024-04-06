_: let
  asPath = paths: map (path: ../../home + "/${path}") paths;
in {
  home.stateVersion = "23.11";
  xdg.enable = true;

  imports = asPath [
    "stylix"

    # Wayland ?
    # "wayland/river"
    "wayland/hyprland"
    # "anyrun"
    "gtk-theme"
    "ags"

    # x11 aka. xmonad in my case
    # "x11"

    "kitty"
    # "flatpak"

    "shells/zsh"

    "editors/helix"
    # "editors/neovim"

    "guix"

    "cli-tools"
    "lazygit"
    "newsboat"
    "dunst"

    # "nyxt"
    "spotify"
    "user-apps"

    "development"

    # Virtualisation attempts
    # --- single gpu pass through (nvidia rtx 3080)
    "virtual"
  ];
}
