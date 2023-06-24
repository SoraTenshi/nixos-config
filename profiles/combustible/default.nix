{ self, ... }:
{
  home.stateVersion = "23.05";
  imports = [
    "${self}/home/kitty"

    "${self}/home/editors/helix"

    "${self}/home/shells/zsh"

    "${self}/home/cli-tools"
  ];
}
