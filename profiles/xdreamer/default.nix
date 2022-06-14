{ config, ... }:

{
  imports = [
    # ui
    ../../ui/x11/xmonad.nix

    # General purpose
    ../../general-purpose/cli-tools.nix
    
    # User applications
    ../../applications/alacritty.nix
    ../../applications/user-apps.nix

    # development
    ../../development/developing.nix
  ];
}
