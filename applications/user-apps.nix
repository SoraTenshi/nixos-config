{ config, pkgs, nixpkgs, lib, dotfiles, ... }:
{
  home.packages = with pkgs; [
    discord steam

    qmk

    freshfetch

    # browser
    # vivaldi 
    firefox
    qutebrowser

    # Screenshots!
    flameshot

    # Pic editing
    # gimp
    peek
  ];

  xsession.initExtra = ''
    ${lib.concatMapStrings (s: s + " & \n") (
      "flameshot"
      )}
  '';
}
