{ pkgs, config, ... }:

{
  imports = [
    # General purpose
    ../../general-purpose/nvim.nix
    ../../general-purpose/zsh.nix
    ../../general-purpose/misc.nix
    ../../general-purpose/helix.nix

    ../../applications/alacritty.nix

    # development
    ../../development/developing.nix
  ];
}
