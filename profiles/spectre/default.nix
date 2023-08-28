{ ... }:
{
  home.stateVersion = "23.05";
  xdg.enable = true;

  imports = [
    ../../home/x11

    ../../home/kitty

    ../../home/shells/zsh

    ../../home/editors/helix

    ../../home/cli-tools
    ../../home/lazygit
    
    ../../home/user-apps

    # ../../home/development
    ../../home/development/darwin.nix
  ];
}
