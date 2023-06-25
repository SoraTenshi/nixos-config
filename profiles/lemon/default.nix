{ ... }:
{
  home.stateVersion = "23.05";
  xdg.enable = true;

  imports = [
    ../../home/kitty

    ../../home/editors/helix

    ../../home/development/darwin.nix
    ../../home/user-apps/darwin.nix

    ../../home/shells/zsh

    ../../home/cli-tools
  ];
}
