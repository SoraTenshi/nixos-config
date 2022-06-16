{ config, pkgs, nixpkgs, lib, dotfiles, ... }:
{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    discord steam

    qmk

    freshfetch

    # browser
    # vivaldi 
    qutebrowser

    # Screenshots!
    flameshot

    # Desktop notifications demon
    dunst

    # Pic editing
    # gimp
  ];

  xsession.initExtra = ''
    ${lib.concatMapStrings (s: s + " & \n") (
      "flameshot"
      )}
  '';
}
