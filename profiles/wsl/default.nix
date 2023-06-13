{ ... }:

{
  home.stateVersion = "23.05";
  manual.manpages.enable = false;

  imports = [
    # General purpose
    ../../general-purpose/cli-tools.nix

    ../../applications/kitty.nix

    # Nyxt
    ../../applications/nyxt.nix

    # development
    ../../development/developing.nix
  ];
}
