{ ... }:
{
  home.stateVersion = "23.05";
  xdg.enable = true;

  imports = [
    ../../home/kitty

    ../../home/development/darwin.nix
    ../../home/user-apps/darwin.nix

    ../../home/editors/helix
    ../../home/editors/neovim

    ../../home/shells/zsh

    ../../home/lazygit
    ../../home/newsboat
    ../../home/cli-tools
  ];
}
