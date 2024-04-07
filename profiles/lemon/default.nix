_: let
  asPath = paths: map (path: ../../home + "/${path}") paths;
in {
  home.stateVersion = "23.11";
  xdg.enable = true;

  imports = asPath [
    "cli-tools"
    "kitty"
    "lazygit"
    "newsboat"

    "development/darwin.nix"
    "editors/helix"
    "shells/zsh"
    "user-apps/darwin.nix"
  ];
}
