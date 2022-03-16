{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  config.allowUnfree = true;

  home.packages = with pkgs; [
    # Well... of course!
    discord steam vivaldi

    # Screenshots!
    flameshot

    # Pic editing
    gimp
  ];

}
