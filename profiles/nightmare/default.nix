_:
{
  home.stateVersion = "23.11";
  xdg.enable = true;

  imports = [
    ../../home/ags
    # General purpose
    ../../home/editors/helix

    ../../home/cli-tools

    # ../../home/nyxt

    ../../home/development
    ../../home/lazygit

    ../../home/shells/zsh
  ];
}
