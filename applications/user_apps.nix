{ config, pkgs, nixpkgs, lib, ... }:
{
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "discord"
    "vivaldi"
    "steam"
  ];

  home.packages = with pkgs; [
    # Screenshots!
    flameshot

    # Pic editing
    gimp
  ];

}
