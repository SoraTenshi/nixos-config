_:
let asPath = paths: map (path: ../../home + "/${path}") paths;
in {
  home.stateVersion = "23.11";
  xdg.enable = true;

  imports = asPath [
    "cli-tools"
    "development"
    # "lazygit"
    "spotify-player"
    "jj"
    "pwn"

    "editors/helix"
    "shells/zsh"
  ];
}
