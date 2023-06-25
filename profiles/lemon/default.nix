{ ... }:
{
  home.stateVersion = "23.05";
  xdg.enable = true;

  imports = [
    ../../home/kitty"

    ../../home/editors/helix"

    ../../home/shells/zsh"

    ../../home/cli-tools"
  ];
}
