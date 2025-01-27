_:
let asPath = paths: map (path: ../../home + "/${path}") paths;
in {
  home.stateVersion = "24.11";
  xdg.enable = true;

  imports = asPath [
    "anki"
    "cli-tools"
    # "ghostty" # currently broken on macos
    "kitty"
    "jj"
    "newsboat"

    "development/darwin.nix"
    "editors/helix"
    "shells/zsh"
    "user-apps/darwin.nix"
  ];
}
