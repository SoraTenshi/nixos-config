{ pkgs, config, ... }:

{
  imports = [
    # General purpose
    ../../general-purpose/cli-tools.nix

    # development
    ../../development/developing.nix
  ];
}
