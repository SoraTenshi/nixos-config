{ self, pkgs, config, home, ... }:

{
  home.stateVersion = "22.11";

  imports = [
    # General purpose
    ../../general-purpose/cli-tools.nix

    # development
    ../../development/developing.nix
  ];
}
