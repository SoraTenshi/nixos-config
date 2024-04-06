_: {
  home.stateVersion = "23.11";
  xdg.enable = true;

  imports = [
    ../../home/stylix
    ../../home/x11

    ../../home/kitty

    ../../home/shells/zsh

    ../../home/editors/helix

    ../../home/cli-tools
    ../../home/lazygit

    ../../home/development/darwin.nix
  ];
}
