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
    "development"
    "discord"
    "steam"
    "input-leap"
    "kitty"
    "jj"
    # "newsboat"

    "editors/helix"
    "shells/zsh"
  ];
}
