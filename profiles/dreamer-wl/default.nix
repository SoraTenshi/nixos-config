{ self, config, pkgs, ... }:

{
  imports = [
    # ui
    ../../ui/wayland/river.nix

    # General purpose
    ../../general-purpose/cli-tools.nix

    # User applications
    ../../applications/apps.nix

    # development
    ../../development/developing.nix
  ];
}
