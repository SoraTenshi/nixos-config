_:
{
  home.stateVersion = "23.05";
  xdg.enable = true;

  imports = [
    # General purpose
    ../../home/editors/helix

    ../../home/cli-tools

    ../../home/development
    ../../home/lazygit

    ../../home/shells/zsh
  ];
}
