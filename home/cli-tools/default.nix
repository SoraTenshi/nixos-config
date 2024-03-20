{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ani-cli
    btop bottom
    gomuks
    ncdu
    neofetch
    tiny
    tldr
    tmate
    unzip
  ];
}
