_:
let asPath = paths: map (path: ../../home + "/${path}") paths;
in {
  home.stateVersion = "23.11";
  xdg.enable = true;

  imports = asPath [
    "cli-tools"
    "ghostty"
    "development"
    "flatpak"
    # "lazygit"
    "spotify-player"
    "jj"
    "pwn"
    "weechat"

    "editors/helix-steel"
    "editors/helix"
    "shells/zsh"
    "shells/schemesh"
  ];
}
