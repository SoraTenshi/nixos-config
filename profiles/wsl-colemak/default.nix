{ pkgs, config, ... }:

{
  imports = [
    # General purpose
    ../../general_purpose/nvim_colemak.nix
    ../../general_purpose/zsh.nix
    ../../general_purpose/misc.nix

    # development
    ../../development/c.nix
    ../../development/zig.nix
    ../../development/rust.nix
    ../../development/misc.nix
    ../../development/tools.nix
  ];
}
