{ config, ... }:

{
  imports = [
    # ui
    ../../ui/x11/xmonad.nix

    # General purpose
    ../../general-purpose/nvim.nix
    ../../general-purpose/zsh.nix
    ../../general-purpose/misc.nix
    ../../general-purpose/helix.nix

    # User applications
    ../../applications/alacritty.nix
    ../../applications/user-apps.nix

    # development
    ../../development/developing.nix
  ];
}
