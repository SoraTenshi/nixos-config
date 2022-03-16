{ config, pkgs, nixpkgs, lib, ... }:
{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    discord vivaldi steam

    # Screenshots!
    flameshot

    # Pic editing
    gimp
  ];

}
