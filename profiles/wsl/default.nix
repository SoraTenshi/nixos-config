{ home, ... }:

{
  home.stateVersion = "22.11";
  manual.manpages.enable = false;

  imports = [
    # General purpose
    ../../general-purpose/cli-tools.nix

    # development
    ../../development/developing.nix
  ];
}
