{ lib, ... }:
let asPath = paths: map (path: ../../home + "/${path}") paths;
in {
  home.stateVersion = "26.05";
  home.homeDirectory = lib.mkForce "/Users/lemon";
  xdg.enable = true;

  imports = asPath [
    # "anki"
    "cli-tools"
    # "ghostty" # currently broken on macos
    "development"
    "discord"
    "darwin"
    # "steam"
    "input-leap"
    "kitty"
    "jj"
    # "newsboat"

    "editors/helix"
    "shells/zsh"
  ];
}
