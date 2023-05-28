{ ... }:

{
  home.stateVersion = "23.05";
  manual.manpages.enable = false;

  imports = [
    # ui
    ../../ui/x11/xmonad.nix

    # wl
    ../../ui/wl/tools.nix

    # General purpose
    ../../general-purpose/cli-tools.nix
    
    # User applications
    ../../applications/apps.nix

    # development
    ../../development/developing.nix
  ];
}
