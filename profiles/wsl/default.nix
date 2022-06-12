{ pkgs, config, ... }:

{
  imports = [
    # General purpose
    ../../general_purpose/nvim.nix
    ../../general_purpose/zsh.nix
    ../../general_purpose/misc.nix
    ../../general_purpose/helix.nix

    ../../applications/alacritty.nix

    # development
    ../../development/developing.nix
  ];
}
