{ config, pkgs, nixpkgs, lib, dotfiles, ... }:
{
  home.packages = with pkgs; [
    discord steam

    qmk

    freshfetch

    # browser
    # vivaldi 
    qutebrowser

    # Screenshots!
    flameshot

    # Pic editing
    # gimp
  ];

  xsession.initExtra = ''
    ${lib.concatMapStrings (s: s + " & \n") (
      "flameshot"
      )}
  '';
}
