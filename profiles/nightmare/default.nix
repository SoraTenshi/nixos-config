{ ... }:
{
  home.stateVersion = "23.05";
  imports = [
    # General purpose
    ../../home/editors/helix

    ../../home/cli-tools

    ../../home/development

    ../../home/shells/zsh
  ];
}
