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
    # ../../home/editors/emacs

    ../../home/shells/zsh
    ../../home/shells/elvish

    ../../home/lazygit
    ../../home/newsboat
    ../../home/cli-tools
  ];
}
