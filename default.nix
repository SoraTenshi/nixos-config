# Used for the configuration of specific configurations

{ config, pkgs, ... }:

{
  # Enable the usage of home-manager
  # The point of home-manager is to create
  # symlinks from /nix/store
  program.home-manager.enable = true;

  home.packages = with pkgs; [

  ];

}
