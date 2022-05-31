{ config, pkgs, nixpkgs, lib, dotfiles, ... }:
{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    discord steam

    neofetch

    qmk

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

  home.file = {
    ".config/qutebrowser/config.py" = {
      source = "${dotfiles}/qutebrowser/config.py";
    };
  };

  home.file = {
    ".Xresources" = {
      source = "${dotfiles}/xresource/tokyo-night-storm.Xresources";
    };
  };
}
