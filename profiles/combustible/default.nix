{ self, ... }:
{
  imports = [
    "${self}/home/kitty"
    "${self}/home/editors/helix"
    "${self}/home/shells/zsh"
    "${self}/home/cli-tools"
  ];
}
