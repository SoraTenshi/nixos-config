{ config, lib, pkgs, ... }:

{
  home-manager.users."nixos" = { pkgs, nixpkgs, ...}: {
    imports = [
      # General purpose
      ../../general_purpose/nvim.nix
      ../../general_purpose/zsh.nix

      # development
      ../../development/c.nix
      ../../development/zig.nix
      ../../development/rust.nix
      ../../development/misc.nix
    ];
  };
}
