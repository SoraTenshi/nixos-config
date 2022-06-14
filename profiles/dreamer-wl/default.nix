{ config, pkgs, ... }:

{
  imports = [
    # ui
    ../../ui/wayland/river.nix

    # General purpose
    ../../general-purpose/nvim.nix
    ../../general-purpose/zsh.nix
    ../../general-purpose/misc.nix

    # User applications
    ../../applications/alacritty.nix
    ../../applications/user-apps.nix

    # development
    ../../development/developing.nix
  ];
}
