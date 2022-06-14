{ pkgs, config, ... }:

{
  imports = [
    # General purpose
    ../../general-purpose/cli-tools-colemak.nix

    # development
    ../../development/developing.nix
  ];
}
