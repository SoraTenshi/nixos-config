{ ... }:

{
  home.stateVersion = "unstable";
  manual.manpages.enable = false;

  imports = [
    # General purpose
    ../../general-purpose/cli-tools.nix

    # development
    ../../development/developing.nix
  ];
}
