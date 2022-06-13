{ config, pkgs, dotfiles, ... }:

{
  imports = [
    # ui
    ../../ui/x11/xmonad.nix

    # General purpose
    ../../general_purpose/nvim.nix
    ../../general_purpose/zsh.nix
    ../../general_purpose/misc.nix
    ../../general_purpose/helix.nix

    # User applications
    ../../applications/alacritty.nix
    ../../applications/user_apps.nix

    # development
    ../../development/developing.nix
  ];
}
