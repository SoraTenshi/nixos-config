{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    gomuks
    ncdu
    neofetch
    tiny
    tldr
    tmate
    unzip
  ];
}
