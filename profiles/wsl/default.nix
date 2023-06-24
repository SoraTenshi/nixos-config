{ self, ... }:
{
  home.stateVersion = "23.05";
  imports = [
    # General purpose
    "${self}/home/editors/helix"

    "${self}/home/cli-tools"

    "${self}/home/development"

    "${self}/home/shells/zsh"
  ];
}
