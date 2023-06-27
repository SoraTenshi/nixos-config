{ ... }:
{
  home.stateVersion = "23.05";
  xdg.enable = true;

  imports = [
    ../../home/kitty

    ../../home/editors/helix
    ../../home/editors/neovim

    ../../home/development/darwin.nix
    ../../home/user-apps/darwin.nix

    ../../home/shells/zsh

    ../../home/lazygit

    ../../home/cli-tools
  ];
}
