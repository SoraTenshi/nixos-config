{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ani-cli
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
