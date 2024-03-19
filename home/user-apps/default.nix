{ pkgs, ... }:
{
  home.packages = with pkgs; [
    steam

    discord

    qmk vial

    firefox
    mumble
    zathura
    keepassxc
    dino
    spacedrive
  ];
}
