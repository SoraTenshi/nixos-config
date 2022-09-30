{ config, pkgs, home, ... }:

{
  home.stateVersion = "22.11";

  imports = [
    # ui
    ../../ui/x11/xmonad.nix

    # General purpose
    ../../general-purpose/cli-tools.nix
    
    # User applications
    ../../applications/apps.nix

    # development
    ../../development/developing.nix
  ];
}
