{ lib, ... }:
let asPath = paths: map (path: ../../home + "/${path}") paths;
in {
  home.stateVersion = "24.11";
  home.homeDirectory = lib.mkForce "/Users/lemon";
  xdg.enable = true;

  imports = asPath [
    # "anki"
    "cli-tools"
    # "ghostty" # currently broken on macos
    "discord"
    "kitty"
    "jj"
    "newsboat"

    "development/darwin.nix"
    "editors/helix"
    "shells/zsh"
    "user-apps/darwin.nix"
  ];
}
