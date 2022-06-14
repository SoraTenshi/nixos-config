{ config, pkgs, ... }:

{
  imports = [
    # ui
    ../../ui/x11/x11.nix

    # General purpose
    ../../general-purpose/cli-tools.nix
    
    # User applications
    ../../applications/apps.nix

    # development
    ../../development/developing.nix
  ];
}
