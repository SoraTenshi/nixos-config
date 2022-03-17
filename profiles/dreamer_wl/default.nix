{ config, pkgs, ... }:

{
  imports = [
    # User applications
    ../../applications/alacritty.nix
    ../../applications/user_apps.nix
    ../../applications/wayland/river.nix

    # General purpose
    ../../general_purpose/nvim.nix
    ../../general_purpose/zsh.nix

    # development
    ../../development/c.nix
    ../../development/zig.nix
    ../../development/rust.nix
    ../../development/misc.nix
    ../../development/tools.nix
  ];
}
