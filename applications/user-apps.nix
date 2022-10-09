{ config, pkgs, nixpkgs, lib, ... }:
{
  home.packages = with pkgs; [
    discord steam

    qmk

    freshfetch

    # browser
    # vivaldi 
    firefox

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
