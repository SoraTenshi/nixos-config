_: let
  asPath = paths: map (path: ../../home + "/${path}") paths;
in {
  home.stateVersion = "23.11";
  xdg.enable = true;

  imports = asPath [
    "cli-tools"
    "kitty"
    "lazygit"
    "stylix"
    "x11"

    "development/darwin.nix"
    "editors/helix"
    "shells/zsh"
  ];
}
