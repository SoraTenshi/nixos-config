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
      "${pkgs.flameshot}/bin/flameshot"
      "fcitx5"
      )}
  '';

  home.file = {
    ".config/qutebrowser.configdata.yml" = {
      source = "${dotfiles}/qutebrowser/configdata.yml";
    };
  };
}
