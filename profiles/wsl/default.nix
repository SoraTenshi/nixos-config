{ pkgs, config, ... }:

{
  imports = [
    # General purpose
    ../../general_purpose/nvim.nix
    ../../general_purpose/zsh.nix
    ../../general_purpose/misc.nix

    # development
    ../../development/developing.nix
  ];
}
