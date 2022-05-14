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

  home.file = {
    ".config/qutebrowser.configdata.yml" = {
      source = "${dotfiles}/qutebrowser/configdata.yml";
    };
  };
}
