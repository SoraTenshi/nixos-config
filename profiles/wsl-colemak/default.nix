{ pkgs, config, ... }:

{
  imports = [
    # General purpose
    ../../general-purpose/nvim-colemak.nix
    ../../general-purpose/zsh.nix
    ../../general-purpose/misc.nix

    # development
    ../../development/developing.nix
  ];
}
