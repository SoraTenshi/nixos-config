{ ... }:
{
  home.stateVersion = "23.05";
  manual.manpages.enable = false;

  imports = [
    # ui
    ../home/x11/xmonad.nix

    # wl
    ../home/wl/tools.nix

    # General purpose
    ../home/general-purpose/cli-tools.nix
    
    # User applications
    ../../applications/apps.nix

    # development
    ../../development/developing.nix
  ];
}
